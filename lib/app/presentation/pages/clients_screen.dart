import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/blocs/list_client/list_client_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/components/components.dart';
import 'package:flutter_web/routes.dart';
import 'package:go_router/go_router.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    context.read<ListClientBloc>().add(
          GetAllClient(selection is SelectionOffset ? true : false),
        );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final width = MediaQuery.of(context).size.width - 200;
    final bool isSmallScreen = width < 600;
    final bool isMediumScreen = width >= 600 && width <= 1024;
    final bool isLargeScreen = width > 1024;

    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state is ClientSuccess) {
          final selection = context.read<SelectionBloc>().state;
          context.read<ListClientBloc>().add(
                GetAllClient(selection is SelectionOffset),
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
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<ListClientBloc, ListClientState>(
                    builder: (context, state) {
                      if (state is ListClientFailure) {
                        return Center(
                          child: Text('Failed to fetch client'),
                        );
                      } else if (state is ListClientSuccess) {
                        if (state.clients.isEmpty) {
                          return Center(
                            child: Text('No client found'),
                          );
                        }

                        print(state.clients);

                        return ListView.builder(
                          itemCount: state.clients.length,
                          itemBuilder: (context, index) {
                            return CardClient(
                              client: state.clients[index],
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: isSmallScreen ? 15 : 40,
                        bottom: isSmallScreen ? 15 : 40,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.push(NamedRoutes.clientAdd);
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
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
