import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/data/models/local/order.dart';
import 'package:flutter_web/app/presentation/components/timelines_widget.dart';
import 'package:flutter_web/app/presentation/components/timelines_widget_2.dart';
import 'package:flutter_web/app/presentation/presentation.dart';
import 'package:flutter_web/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CardTile extends StatefulWidget {
  const CardTile({
    this.order,
    this.isOrder = true,
    super.key,
  });

  final Order? order;
  final bool isOrder;

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  Color status = Colors.green;
  // String format datetime 2024-11-03
  String _format = 'yyyy-MM-dd';
  bool isExpanded = false;
  bool isShowProgress = false;

  DateTime dateIn = DateTime.now().subtract(Duration(days: 2));
  DateTime dateOut = DateTime.now().add(Duration(days: 3));

  List<String> _detailOrder = [
    'Oplah Soft Cover',
    'Oplah Hard Cover',
    'Oplah Cover Lidah',
    'Ukuran',
    'Kertas Cover',
    'Kertas Isi',
    'Cetak Isi',
    'Cetak Cover',
    'Laminasi Cover',
    'Finishing Cover',
  ];

  void showDeleteDialog(
    BuildContext context,
    Order order,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget.isOrder ? 'Hapus Orderan' : 'Hapus Orderan dari History',
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus orderan ini? menjadi ${widget.isOrder ? 'History' : 'aktif'}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                context.pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                // Tambahkan logika penghapusan akun di sini
                context.read<OrderBloc>().add(
                      UpdateOrder(
                        order.copyWith(
                          isActive: widget.isOrder ? false : true,
                        ),
                        order.idClient!,
                      ),
                    );
                context.read<ListOrderBloc>().add(GetAllOrder(
                      context.read<SelectionBloc>().state is SelectionOffset,
                    ));
                context.pop(); // Menutup dialog setelah menghapus
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // final selection = context.read<SelectionBloc>().state;

    // context.read<ListOrderBloc>().add(
    //       GetAllOrder(
    //         selection is SelectionOffset,
    //       ),
    //     );
    context.read<GetClientBloc>().add(GetClient(widget.order!.idClient!));
    //convert dateIn and Out use _format
    final formatter = DateFormat(_format);
    dateIn = formatter.parse(widget.order!.tanggalMasuk!);
    dateOut = formatter.parse(widget.order!.tanggalSelesai!);
  }

  String getDeadlineStatus(DateTime deadline) {
    // Mendapatkan tanggal saat ini
    DateTime now = DateTime.now();

    // Menghitung selisih antara deadline dan tanggal saat ini
    Duration difference = deadline.difference(now);

    // Menambahkan 1 hari untuk menghitung hari deadline
    int daysLeft = difference.inDays + (difference.isNegative ? 0 : 1);

    // Mengecek apakah deadline sudah lewat atau masih dalam rentang waktu
    if (difference.isNegative) {
      // Jika sudah lewat, return 'Sekarang' atau bisa disesuaikan
      return 'Deadline : Sekarang';
    } else {
      // Jika masih ada waktu, return selisih dalam hari
      return 'Deadline : $daysLeft hari lagi';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = false;
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isMediumScreen = width >= 600 && width <= 1240;
    String keterangan = '';

    keterangan = getDeadlineStatus(dateOut);

    print('Width $width');

    // DateTime dateIn = DateTime.now().subtract(Duration(days: 2));
    // DateTime dateOut = DateTime.now().add(Duration(days: 3));
    int remaining = dateOut.difference(DateTime.now()).inDays;
    print('Width $width');

    // 1240

    if (remaining > 0) {
      // keterangan = 'Waktu tersisa $remaining hari lagi.';
      if (remaining > 3) {
        status = Colors.green;
      } else {
        status = Colors.yellow;
      }
    } else if (remaining == 0) {
      status = Colors.red;
    } else {}

    return MultiBlocListener(
      listeners: [
        BlocListener<StepBloc, StepsState>(
          listener: (context, state) {
            if ((state is StepSuccess) & isFirstTime == false) {
              setState(() {
                isFirstTime = true;
              });
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: status,
                ),
              ),
              8.sbw(),
              Expanded(
                child: ExpansionTile(
                  title: Text(
                    widget.order!.judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (isExpanded) {
                    print('Expanded $isExpanded');
                    setState(() {
                      isExpanded = isExpanded;
                    });
                    if (isExpanded) {
                      // print('Expanded');
                    } else {
                      // print('Collapsed');
                      setState(() {
                        isShowProgress = false;
                      });
                    }
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chat),
                        onPressed: () async {
                          var phone = widget.order!.client!.phone;
                          //replace fisrt 0 with 62
                          phone = phone!.replaceFirst('0', '62');
                          final Uri _phoneLaunch = Uri.parse(
                              "https://api.whatsapp.com/send?phone=${phone}&");
                          print('Phone $_phoneLaunch');
                          print('Phone $phone');
                          if (!await launchUrl(_phoneLaunch)) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Error'),
                                content: Text('Could not launch $phone'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      //arrow down and up when expanded
                      Icon(
                        isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer: ${widget.order!.client!.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Phone: ${widget.order!.client!.phone}',
                      ),
                      Text(
                        'Tanggal Masuk: ${DateFormat('dd MMM yyyy').format(dateIn)}',
                      ),
                      Text(
                        'Tanggal Selesai: ${DateFormat('dd MMM yyyy').format(dateOut)}',
                      ),
                      4.sbh(),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            keterangan,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          isMediumScreen || isSmallScreen
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Detail Orderan:',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    8.sbh(),
                                    // for (String detail in _detailOrder)
                                    //   Text(
                                    //     '$detail : Lorem ipsum dolor sit amet',
                                    //     style: const TextStyle(fontSize: 14),
                                    //   ),
                                    Text(
                                      'Opla Soft Cover: ${widget.order!.oplahSoftCover}',
                                    ),
                                    Text(
                                      'Opla Hard Cover: ${widget.order!.oplahHardCover}',
                                    ),
                                    Text(
                                      'Opla Cover Lidah: ${widget.order!.oplahCoverLidah}',
                                    ),
                                    Text(
                                      'Ukuran: ${widget.order!.ukuran}',
                                    ),
                                    Text(
                                      'Kertas Isi: ${widget.order!.kertasIsi}',
                                    ),
                                    Text(
                                      'Kertas Cover: ${widget.order!.kertasCover}',
                                    ),

                                    Text(
                                      'Cetak Isi: ${widget.order!.cetakIsi}',
                                    ),
                                    Text(
                                      'Cetak Cover: ${widget.order!.cetakCover}',
                                    ),
                                    Text(
                                      'Laminasi Cover: ${widget.order!.laminasiCover}',
                                    ),
                                    Text(
                                      'Finishing Cover: ${widget.order!.finishingCover}',
                                    ),
                                    16.sbh(),
                                    CustomCalendar(
                                      width: 600,
                                      height: 400,
                                      rangeStart: dateIn,
                                      rangeEnd: dateOut,
                                    ),

                                    16.sbh(),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            context.push(
                                              NamedRoutes.orderEdit,
                                              extra: widget.order,
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: const Text('Edit'),
                                        ),
                                        8.sbw(),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDeleteDialog(
                                                context, widget.order!);
                                          },
                                          icon: Icon(widget.isOrder
                                              ? Icons.delete
                                              : Icons.restore),
                                          label: Text(
                                            widget.isOrder
                                                ? 'Delete'
                                                : 'Restore',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Detail Orderan:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        8.sbh(),
                                        detailOrder(widget.order!),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.timer,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              keterangan,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        16.sbh(),
                                        Row(
                                          children: [
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                context.push(
                                                  NamedRoutes.orderEdit,
                                                  extra: widget.order,
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                              label: const Text('Edit'),
                                            ),
                                            8.sbw(),
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                showDeleteDialog(
                                                    context, widget.order!);
                                              },
                                              icon: Icon(
                                                widget.isOrder
                                                    ? Icons.delete
                                                    : Icons.restore,
                                              ),
                                              label: Text(
                                                widget.isOrder
                                                    ? 'Delete'
                                                    : 'Restore',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    CustomCalendar(
                                      width: 600,
                                      height: 400,
                                      rangeStart: dateIn,
                                      rangeEnd: dateOut,
                                    ),
                                  ],
                                ),
                          16.sbh(),
                          Divider(),
                          isShowProgress
                              ? Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: TimelinesWidget2(
                                        title: 'Cetak Cover',
                                        list: widget.order!.processes!
                                            .where(
                                              (element) {
                                                return element.namaProses ==
                                                    'Cetak Cover';
                                              },
                                            )
                                            .first
                                            .steps!,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TimelinesWidget2(
                                        title: 'Cetak Cover',
                                        list: widget.order!.processes!
                                            .where(
                                              (element) {
                                                return element.namaProses ==
                                                    'Cetak Isi';
                                              },
                                            )
                                            .first
                                            .steps!,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TimelinesWidget2(
                                        title: 'Cetak Cover',
                                        list: widget.order!.processes!
                                            .where(
                                              (element) {
                                                return element.namaProses ==
                                                    'Finishing';
                                              },
                                            )
                                            .first
                                            .steps!,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isShowProgress = !isShowProgress;
                                });
                              },
                              child: Text(
                                isShowProgress
                                    ? 'Sembunyikan Progress'
                                    : 'Tampilkan Progress',
                                style: TextStyle(
                                  color:
                                      isShowProgress ? Colors.red : Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailOrder(
    Order order,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opla Soft Cover: ${order.oplahSoftCover}',
        ),
        Text(
          'Opla Hard Cover: ${order.oplahHardCover}',
        ),
        Text(
          'Opla Cover Lidah: ${order.oplahCoverLidah}',
        ),
        Text(
          'Ukuran: ${order.ukuran}',
        ),
        Text(
          'Kertas Cover: ${order.kertasCover}',
        ),
        Text(
          'Kertas Isi: ${order.kertasIsi}',
        ),
        Text(
          'Cetak Isi: ${order.cetakIsi}',
        ),
        Text(
          'Cetak Cover: ${order.cetakCover}',
        ),
        Text(
          'Laminasi Cover: ${order.laminasiCover}',
        ),
        Text(
          'Finishing Cover: ${order.finishingCover}',
        ),
      ],
    );
  }
}
