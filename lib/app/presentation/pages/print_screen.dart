import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/presentation/components/components.dart';
import 'package:flutter_web/app/presentation/pages/order_screen.dart';
import 'package:go_router/go_router.dart';

import '../../data/blocs/list_printer/list_printer_bloc.dart';
import '../../data/data.dart';
import '../../data/models/local/printer.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  void initState() {
    super.initState();
    final selection = context.read<SelectionBloc>().state;
    context.read<ListPrinterBloc>().add(
          GetAllPrinter(selection is SelectionOffset),
        );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 200;
    final Color primaryColor = Theme.of(context).primaryColor;
    final bool isSmallScreen = width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              FormAction(),
              Expanded(
                child: BlocBuilder<ListPrinterBloc, ListPrinterState>(
                  builder: (context, state) {
                    if (state is ListPrinterSuccess) {
                      if (state.printers.isNotEmpty) {
                        return ListView.builder(
                          itemCount: state.printers.length,
                          itemBuilder: (context, index) {
                            return PrintCard(printer: state.printers[index]);
                          },
                        );
                      } else {
                        return Center(
                          child: Text('Data tidak ditemukan'),
                        );
                      }
                    } else if (state is ListPrinterFailure) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
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
                  context.push(NamedRoutes.printerAdd);
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
          )
        ],
      ),
    );
  }
}

class PrintCard extends StatefulWidget {
  const PrintCard({
    this.printer,
    this.events = const {},
    super.key,
  });

  final Printer? printer;
  final Map<DateTime, List<Event>> events;

  @override
  State<PrintCard> createState() => _PrintCardState();
}

class _PrintCardState extends State<PrintCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: Text(
            widget.printer?.name ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // context.push(
                  //   NamedRoutes.orderEdit,
                  //   extra: widget.order,
                  // );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              10.sbw(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: Icon(Icons.delete),
                label: Text(
                  'Delete',
                ),
              ),
            ],
          ),
          childrenPadding: EdgeInsets.all(10),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // memberitahu user bahwa print terdapat di dalam printer
            Text(
              'Order terdapat di dalam printer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              height: 550,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.builder(
                        itemCount: widget.printer!.orders!.length,
                        itemBuilder: (context, index) {
                          // return CardTile(
                          //   order: widget.printer!.orders![index],
                          //   isOrder: true,
                          // );
                          return Container(
                            width: double.maxFinite,
                            height: 100,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ${index + 1}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Status: Ongoing',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Tanggal Cetak: ${widget.printer!.orders![index].tanggalMasuk}',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  10.sbw(),
                  Expanded(
                    // child: EventCalendar(
                    //   events: widget.events,
                    // ),
                    child: TableEventsExample(
                      events: {
                        DateTime.utc(2024, 11, 26): [
                          Event('Order 1'),
                          Event('Order 2'),
                        ],
                        convertUTC(DateTime.now().add(Duration(days: 1))): [
                          Event('Order 3'),
                          Event('Order 4'),
                        ],
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
