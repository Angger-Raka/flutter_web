import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/data/blocs/list_order/list_order_bloc.dart';
import 'package:flutter_web/app/data/blocs/selection/selection_bloc.dart';
import 'package:flutter_web/app/presentation/components/components.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/named_routes.dart';
import '../../data/blocs/order/order_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    context.read<ListOrderBloc>().add(
          GetAllOrder(
            selection is SelectionOffset,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 200;
    final Color primaryColor = Theme.of(context).primaryColor;
    final bool isSmallScreen = width < 600;

    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          final selection = context.read<SelectionBloc>().state;
          context.read<ListOrderBloc>().add(
                GetAllOrder(
                  selection is SelectionOffset,
                ),
              );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            FormAction(),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: BlocBuilder<ListOrderBloc, ListOrderState>(
                      builder: (context, state) {
                        if (state is ListOrderFailure) {
                          return Center(
                            child: Text('Error ${state.message}'),
                          );
                        } else if (state is ListOrderSuccess) {
                          final data = state.data
                              .where(
                                (element) => element.isActive == true,
                              )
                              .toList();

                          print('data: $data');

                          if (data.isEmpty) {
                            return Center(
                              child: Text('Data is empty'),
                            );
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CardTile(
                                order: data[index],
                                isOrder: true,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: isSmallScreen ? 15 : 40,
                        bottom: isSmallScreen ? 15 : 40,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              final selection =
                                  context.read<SelectionBloc>().state;
                              context.read<ListOrderBloc>().add(
                                    GetAllOrder(
                                      selection is SelectionOffset,
                                    ),
                                  );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: 8.br(),
                              ),
                              child: Icon(
                                Icons.refresh,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          8.sbw(),
                          InkWell(
                            onTap: () {
                              context.push(NamedRoutes.orderAdd);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: 8.br(),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormAction extends StatelessWidget {
  const FormAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.maxFinite,
      height: 50,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: 8.br(),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                hintText: 'Search',
              ),
            ),
          ),
          8.sbw(),
          InkWell(
            child: Container(
              width: 50,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: 8.br(),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
          8.sbw(),
          InkWell(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: 8.br(),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  //filter icon
                  Icon(
                    Icons.filter_list,
                    size: 30,
                  ),
                  4.sbw(),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
