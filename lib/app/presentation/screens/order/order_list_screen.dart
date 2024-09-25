import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/presentation/screens/order/widget_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListOrderBloc>().add(GetAllOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pesanan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ListOrderBloc>().add(GetAllOrder());
        },
        child: Icon(
          Icons.refresh,
        ),
      ),
      body: BlocBuilder<ListOrderBloc, ListOrderState>(
        builder: (context, state) {
          if (state is ListOrderLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListOrderSuccess) {
            if (state.data.isEmpty) {
              return Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment,
                      size: 100,
                    ),
                    6.sbh(),
                    Text(
                      'Data tidak ditemukan / kosong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return CardTile(
                  order: state.data[index],
                );
              },
            );
          } else if (state is ListOrderFailure) {
            return Center(
                child: Text(
              state.message,
            ));
          } else {
            return const Center(
              child: Text('Data tidak ditemukan'),
            );
          }
        },
      ),
    );
  }
}

class CardTile extends StatefulWidget {
  const CardTile({
    this.order,
    super.key,
  });

  final Order? order;

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  var format = DateFormat('dd MMMM yyyy');
  var format1 = DateFormat('yyyy-MM-dd');

  void _showDialog(
    bool isSuccess,
    String text,
    Function afterDismiss,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: isSuccess
              ? Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 50,
                )
              : Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
          title: isSuccess
              ? Text(
                  'Berhasil',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                )
              : Text(
                  'Gagal',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then(
      (value) => afterDismiss(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return BlocListener<DeleteOrderBloc, DeleteOrderState>(
      listener: (context, state) {
        if (state is DeleteOrderSuccess) {
          _showDialog(
            true,
            'Data berhasil dihapus',
            () => context.read<ListOrderBloc>().add(GetAllOrder()),
          );
        } else if (state is DeleteOrderFailed) {
          _showDialog(
            false,
            'Data gagal dihapus',
            () => context.read<ListOrderBloc>().add(GetAllOrder()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          minTileHeight: 100,
          backgroundColor: Colors.black12,
          collapsedBackgroundColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // leading: Image.network(
          //   'https://picsum.photos/300/300',
          //   width: 100,
          //   height: 100,
          //   fit: BoxFit.cover,
          // ),
          leading: Icon(
            Icons.book,
            size: 50,
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Aktif',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ),
              8.sbw(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                child: Text(
                  DatetimeHelper()
                      .calculateDeadline(widget.order!.tanggalSelesai ?? ''),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Judul: ${order?.judul ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tanggal masuk : ${format.format(
                  DatetimeHelper().parseDate(widget.order!.tanggalMasuk ?? ''),
                )}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Tanggal selesai : ${format.format(
                  DatetimeHelper()
                      .parseDate(widget.order!.tanggalSelesai ?? ''),
                )}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Pengorder : ${widget.order!.pengorder ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          children: [
            DetailOrder(
              order: order,
            ),
            Divider(
              color: Colors.black,
              indent: 8,
              endIndent: 8,
            ),
            ProcessWidget(
              process: order!.processes?.firstWhere(
                (element) => element.namaProses == 'Cetak Isi',
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 8,
              endIndent: 8,
            ),
            ProcessWidget(
              process: order!.processes?.firstWhere(
                (element) => element.namaProses == 'Cetak Cover',
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 8,
              endIndent: 8,
            ),
            ProcessWidget(
              process: order!.processes?.firstWhere(
                (element) => element.namaProses == 'Finishing',
              ),
            ),
            10.sbh(),
          ],
          onExpansionChanged: (bool expanding) {},
        ),
      ),
    );
  }
}

class DetailOrder extends StatelessWidget {
  const DetailOrder({
    this.order,
    super.key,
  });

  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oplah Soft Cover = ${order?.oplahSoftCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Oplah Hard Cover = ${order?.oplahHardCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Oplah Cover Lidah = ${order?.oplahCoverLidah ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Ukuran = ${order?.ukuran ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Kertas Cover = ${order?.kertasCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Kertas Isi = ${order?.kertasIsi ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Cetak Isi = ${order?.cetakIsi ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Cetak Cover = ${order?.cetakCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Laminasi Cover = ${order?.laminasiCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Finishing Cover = ${order?.finishingCover ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.push(
                          NamedRoutes.orderEdit,
                          extra: order,
                        );
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    10.sbw(),
                    ElevatedButton(
                      onPressed: () {
                        //show dialog validate for action
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text(
                                'Apakah anda yakin ingin menghapus data ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<DeleteOrderBloc>()
                                        .add(DeleteOrder(order!));
                                    context.pop();
                                  },
                                  child: Text('Ya'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('Tidak'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            //scale down image
            child: Transform.scale(
              scale: 1,
              child: CalendarPage(
                rangeStart:
                    DatetimeHelper().parseDate(order?.tanggalMasuk ?? ''),
                rangeEnd:
                    DatetimeHelper().parseDate(order?.tanggalSelesai ?? ''),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProcessWidget extends StatefulWidget {
  ProcessWidget({
    this.process,
    super.key,
  });

  final Process? process;

  @override
  State<ProcessWidget> createState() => _ProcessWidgetState();
}

class _ProcessWidgetState extends State<ProcessWidget> {
  @override
  Widget build(BuildContext context) {
    final steps = widget.process?.steps;

    var listStatust = steps?.map((e) => e.statusStep).toList();

    void _showDialog(
      bool isSuccess,
      String text,
      Function afterDismiss,
    ) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: isSuccess
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.green,
                    size: 50,
                  )
                : Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
            title: isSuccess
                ? Text(
                    'Berhasil',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  )
                : Text(
                    'Gagal',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      ).then(
        (value) => afterDismiss(),
      );
    }

    Future<void> showUpdateStep(
      int id,
      String status,
    ) async {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Update',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Progress for Order 1',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                6.sbh(),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    isExpanded: true,
                    value: status,
                    items: [
                      "Belum Dikerjakan",
                      "Sedang Dikerjakan",
                      "Selesai",
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      context.read<UpdateStepBloc>().add(
                            UpdateStep(
                              id: id.toString(),
                              status: value ?? '',
                            ),
                          );
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return BlocListener<UpdateStepBloc, UpdateStepState>(
      listener: (context, state) {
        print('state $state');
        if (state is UpdateStepSuccess) {
          _showDialog(
            true,
            'Data berhasil diupdate',
            () => context.read<ListOrderBloc>().add(GetAllOrder()),
          );
        } else if (state is UpdateStepFailure) {
          _showDialog(
            false,
            'Data gagal diupdate',
            () => context.read<ListOrderBloc>().add(GetAllOrder()),
          );
        }
      },
      child: Container(
        height: 150,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.process?.namaProses ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Timeline.tileBuilder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        itemCount: steps?.length ?? 0,
                        oppositeContentsBuilder: (context, index) {
                          return Container(
                            width: 140,
                            child: Center(
                              child: Text(
                                steps?.elementAt(index).namaStep ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                        contentsBuilder: (context, index) {
                          final status = steps?.elementAt(index).statusStep;
                          Color color = Colors.red;
                          String text = '';

                          switch (status) {
                            case 'Selesai':
                              color = Colors.green;
                              text = 'Selesai';
                              break;

                            case 'Sedang Dikerjakan':
                              color = Colors.blue;
                              text = 'Proses';
                              break;

                            case 'Belum Dikerjakan':
                              color = Colors.red;
                              text = 'Belum';
                              break;

                            default:
                          }

                          return InkWell(
                            onTap: () {
                              showUpdateStep(
                                steps?.elementAt(index).id ?? 0,
                                steps?.elementAt(index).statusStep ?? '',
                              );
                            },
                            child: Card(
                              color: color,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        indicatorBuilder: (context, index) {
                          final status = steps?.elementAt(index).statusStep;

                          switch (status) {
                            case 'Selesai':
                              return DotIndicator(
                                color: Colors.green,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              );
                            case 'Sedang Dikerjakan':
                              return OutlinedDotIndicator(
                                color: Colors.blue,
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.blue,
                                ),
                              );
                            case 'Belum Dikerjakan':
                              return OutlinedDotIndicator(
                                color: Colors.red,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              );
                            default:
                              return OutlinedDotIndicator(
                                color: Colors.red,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              );
                          }
                        },
                        connectorBuilder: (context, index, type) {
                          final status = steps?.elementAt(index).statusStep;

                          switch (status) {
                            case 'Selesai':
                              return SolidLineConnector(
                                color: Colors.green,
                              );
                            case 'Sedang Dikerjakan':
                              return SolidLineConnector(
                                color: Colors.blue,
                              );
                            case 'Belum Dikerjakan':
                              return SolidLineConnector(
                                color: Colors.red,
                              );
                            default:
                              return SolidLineConnector(
                                color: Colors.red,
                              );
                          }
                        },
                      ),
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
