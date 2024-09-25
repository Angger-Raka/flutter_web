import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:flutter_web/app/data/blocs/add_order/add_order_bloc_bloc.dart';
import 'package:flutter_web/app/presentation/components/custom_textfield.dart';
import 'package:intl/intl.dart';

class OrderAddScreen extends StatefulWidget {
  const OrderAddScreen({super.key});

  @override
  State<OrderAddScreen> createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  //make variable for selected date
  var startDate = DateTime.now();
  var endDate = DateTime.now();

  final pengorderController = TextEditingController();
  final judulController = TextEditingController();
  final oplahSoftCoverController = TextEditingController();
  final oplahHardCoverController = TextEditingController();
  final oplahCoverLidahController = TextEditingController();
  final ukuranController = TextEditingController();
  final kertasIsiController = TextEditingController();
  final kertasCoverController = TextEditingController();
  final cetakIsiController = TextEditingController();
  final cetakCoverController = TextEditingController();
  final laminasiCoverController = TextEditingController();
  final finishingCoverController = TextEditingController();

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
    return BlocListener<AddOrderBloc, AddOrderBlocState>(
      listener: (context, state) {
        if (state is AddOrderBlocSuccess) {
          _showDialog(true, state.message, () {
            Navigator.pop(context);
          });
        } else if (state is AddOrderBlocFailure) {
          _showDialog(false, state.message, () {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Pesanan'),
        ),
        body: Form(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.sbh(),
                  Text(
                    'Tanggal Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.sbh(),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: 8.br(),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${startDate.day}/${startDate.month}/${startDate.year}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        5.sbw(),
                        InkWell(
                          onTap: () {
                            //show date picker
                            showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              //set selected date to variable
                              if (value != null) {
                                setState(() {
                                  startDate = value;
                                });
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: 8.br(),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.sbh(),
                  Text(
                    'Tanggal Selesai',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.sbh(),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: 8.br(),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${endDate.day}/${endDate.month}/${endDate.year}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        5.sbw(),
                        InkWell(
                          onTap: () {
                            //show date picker
                            showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              //set selected date to variable
                              if (value != null) {
                                setState(() {
                                  endDate = value;
                                });
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: 8.br(),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: pengorderController,
                    text: 'Nama Pengorder',
                    hintText: 'Masukkan Nama Pengorder',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: judulController,
                    text: 'Judul',
                    hintText: 'Masukkan Judul',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: oplahSoftCoverController,
                    text: 'Oplah Soft Cover',
                    hintText: 'Masukkan Oplah Soft Cover',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: oplahHardCoverController,
                    text: 'Oplah Hard Cover',
                    hintText: 'Masukkan Oplah Hard Cover',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: oplahCoverLidahController,
                    text: 'Oplah Cover Lidah',
                    hintText: 'Masukkan Oplah Cover Lidah',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: ukuranController,
                    text: 'Ukuran',
                    hintText: 'Masukkan Ukuran',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: kertasIsiController,
                    text: 'Kertas Isi',
                    hintText: 'Masukkan Kertas Isi',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: kertasCoverController,
                    text: 'Kertas Cover',
                    hintText: 'Masukkan Kertas Cover',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: cetakIsiController,
                    text: 'Cetak Isi',
                    hintText: 'Masukkan Cetak Isi',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: cetakCoverController,
                    text: 'Cetak Cover',
                    hintText: 'Masukkan Cetak Cover',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: laminasiCoverController,
                    text: 'Laminasi Cover',
                    hintText: 'Masukkan Laminasi Cover',
                  ),
                  20.sbh(),
                  CustomTextField(
                    controller: finishingCoverController,
                    text: 'Finishing Cover',
                    hintText: 'Masukkan Finishing Cover',
                  ),
                  20.sbh(),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // validate input
                            if (pengorderController.text.isEmpty ||
                                judulController.text.isEmpty ||
                                oplahSoftCoverController.text.isEmpty ||
                                oplahHardCoverController.text.isEmpty ||
                                oplahCoverLidahController.text.isEmpty ||
                                ukuranController.text.isEmpty ||
                                kertasIsiController.text.isEmpty ||
                                kertasCoverController.text.isEmpty ||
                                cetakIsiController.text.isEmpty ||
                                cetakCoverController.text.isEmpty ||
                                laminasiCoverController.text.isEmpty ||
                                finishingCoverController.text.isEmpty) {
                              _showDialog(
                                  false, 'Semua field harus diisi', () {});
                            } else {
                              // add order
                              final format = DateFormat('yyyy-MM-dd');

                              final tanggalMasuk = format.format(startDate);

                              final tanggalSelesai = format.format(endDate);

                              BlocProvider.of<AddOrderBloc>(context).add(
                                AddOrderEvent(
                                  tanggalMasuk: tanggalMasuk,
                                  tanggalSelesai: tanggalSelesai,
                                  pengorder: pengorderController.text,
                                  judul: judulController.text,
                                  oplahSoftCover: oplahSoftCoverController.text,
                                  oplahHardCover: oplahHardCoverController.text,
                                  oplahCoverLidah:
                                      oplahCoverLidahController.text,
                                  ukuran: ukuranController.text,
                                  kertasIsi: kertasIsiController.text,
                                  kertasCover: kertasCoverController.text,
                                  cetakIsi: cetakIsiController.text,
                                  cetakCover: cetakCoverController.text,
                                  laminasiCover: laminasiCoverController.text,
                                  finishingCover: finishingCoverController.text,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: 8.br(),
                            ),
                            child: Center(
                              child: Text(
                                'Simpan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.sbw(),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            judulController.clear();
                            pengorderController.clear();
                            oplahSoftCoverController.clear();
                            oplahHardCoverController.clear();
                            oplahCoverLidahController.clear();
                            ukuranController.clear();
                            kertasIsiController.clear();
                            kertasCoverController.clear();
                            cetakIsiController.clear();
                            cetakCoverController.clear();
                            laminasiCoverController.clear();
                            finishingCoverController.clear();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: 8.br(),
                            ),
                            child: Center(
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  30.sbh(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
