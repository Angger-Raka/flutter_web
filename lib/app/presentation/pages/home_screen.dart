import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/data.dart';

import '../components/custom_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sbh(),
              StatisticsWidget(),
              10.sbh(),
              Row(
                children: [
                  Expanded(child: OrderOverview()),
                  20.sbw(),
                  Expanded(child: PrintOverview()),
                ],
              ),
              ClientOverview()
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => SstatisticsStateWidget();
}

class SstatisticsStateWidget extends State<StatisticsWidget> {
  List<String> item = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Tahun ini',
  ];

  Map<String, List> items = {
    'Orders': [
      Icons.shopping_cart,
      '/orders',
      0,
    ],
    'Clients': [
      Icons.people,
      '/clients',
      0,
    ],
    'History': [
      Icons.history,
      '/history',
      0,
    ],
  };

  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    context.read<ListOrderBloc>().add(
          GetAllOrder(
            selection is SelectionOffset,
          ),
        );
    context.read<ListClientBloc>().add(
          GetAllClient(
            selection is SelectionOffset,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ListOrderBloc, ListOrderState>(
          listener: (context, state) {
            if (state is ListOrderSuccess) {
              items['Orders'] = [
                Icons.shopping_cart,
                '/orders',
                state.data
                    .where(
                      (element) => element.isActive == true,
                    )
                    .length
              ];

              items['History'] = [
                Icons.history,
                '/history',
                state.data
                    .where(
                      (element) => element.isActive == false,
                    )
                    .length
              ];
              setState(() {});
            }
          },
        ),
        BlocListener<ListClientBloc, ListClientState>(
          listener: (context, state) {
            if (state is ListClientSuccess) {
              items['Clients'] = [
                Icons.people,
                '/clients',
                state.clients.length,
              ];
              setState(() {});
            }
          },
        ),
      ],
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              item.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        item.insert(0, item.removeAt(index));
                      });
                    },
                    child: Text(
                      item[index],
                      style: TextStyle(
                        fontSize: 0 == index ? 22 : 14,
                        fontWeight:
                            0 == index ? FontWeight.bold : FontWeight.normal,
                        color: 0 == index ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              // Tentukan lebar tetap untuk setiap item
              double itemWidth = 300;
              int crossAxisCount = (constraints.maxWidth / itemWidth).floor();
              return Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        crossAxisCount, // Jumlah kolom berdasarkan lebar layar
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 6 / 3, // Rasio aspek dari item grid
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    String title = items.keys.elementAt(index);
                    IconData icon = items[title]![0];
                    int count = items[title]![2];

                    return _buildCard(
                      icon,
                      title,
                      count,
                      () {
                        switch (title) {
                          case 'Dashboard':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                            break;
                          case 'Orders':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                            break;
                          case 'Clients':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                            break;
                          case 'History':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(),
                              ),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    String title,
    int count,
    Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 20,
              ),
              child: Icon(
                icon,
                size: 50,
              ),
            ),
            Text(
              'Total $title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderOverview extends StatefulWidget {
  const OrderOverview({super.key});

  @override
  State<OrderOverview> createState() => _OrderOverviewState();
}

class _OrderOverviewState extends State<OrderOverview> {
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
    return Container(
      width: double.maxFinite,
      height: 400,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Due deadline',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              6.sbh(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: 12.br(),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: BlocBuilder<ListOrderBloc, ListOrderState>(
                    builder: (context, state) {
                      if (state is ListOrderSuccess) {
                        if (state.data.isNotEmpty) {
                          final data = state.data
                              .where(
                                (element) => element.isActive == true,
                              )
                              .toList();
                          if (data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                DateTime endDate = DateTime.parse(
                                  data[index].tanggalSelesai!,
                                );

                                final remaining =
                                    endDate.day == DateTime.now().day
                                        ? 0
                                        : endDate.compareTo(DateTime.now());

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    tileColor: Colors.grey[300],
                                    title: Text(data[index].judul),
                                    subtitle: Text(
                                      'Due date: ${data[index].tanggalSelesai} ($remaining days left)',
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text('No data'),
                            );
                          }
                        } else {
                          return Center(
                            child: Text('No data'),
                          );
                        }
                      } else if (state is ListOrderFailure) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrintOverview extends StatefulWidget {
  const PrintOverview({super.key});

  @override
  State<PrintOverview> createState() => _PrintOverviewState();
}

class _PrintOverviewState extends State<PrintOverview> {
  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    context.read<ListPrinterBloc>().add(
          GetAllPrinter(
            selection is SelectionOffset,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 400,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Print Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Many order in print',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              6.sbh(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: 12.br(),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: BlocBuilder<ListPrinterBloc, ListPrinterState>(
                    builder: (context, state) {
                      if (state is ListPrinterSuccess) {
                        if (state.printers.isNotEmpty) {
                          return ListView.builder(
                            itemCount: state.printers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 4,
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tileColor: Colors.grey[300],
                                  title: Text(state.printers[index].name!),
                                  subtitle: Text(
                                    'Total order: ${state.printers[index].orders!.length}',
                                  ),
                                  trailing: Icon(Icons.info_outline),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text('No data'),
                          );
                        }
                      } else if (state is ListPrinterFailure) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientOverview extends StatefulWidget {
  const ClientOverview({super.key});

  @override
  State<ClientOverview> createState() => _ClientOverviewState();
}

class _ClientOverviewState extends State<ClientOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 400,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              6.sbh(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: 12.br(),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: BlocBuilder<ListClientBloc, ListClientState>(
                    builder: (context, state) {
                      if (state is ListClientSuccess) {
                        if (state.clients.isNotEmpty) {
                          return ListView.builder(
                            itemCount: state.clients.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 4,
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tileColor: Colors.grey[300],
                                  title: Text(state.clients[index].name!),
                                  trailing: Icon(Icons.info_outline),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text('No data'),
                          );
                        }
                      } else if (state is ListClientFailure) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
