import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/components/components.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Container(
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
            ),
            Expanded(
              child: BlocBuilder<ListOrderBloc, ListOrderState>(
                builder: (context, state) {
                  if (state is ListOrderFailure) {
                    return Center(
                      child: Text('Error ${state.message}'),
                    );
                  } else if (state is ListOrderSuccess) {
                    final data = state.data
                        .where(
                          (element) => element.isActive == false,
                        )
                        .toList();

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
                          isOrder: false,
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
          ],
        ),
      ),
    );
  }
}
