import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/extensions/extensions.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/components/components.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/blocs/list_client/list_client_bloc.dart';

class OrderActionPage extends StatefulWidget {
  const OrderActionPage({
    super.key,
    this.order,
  });

  final Order? order;

  @override
  State<OrderActionPage> createState() => _OrderActionPageState();
}

class _OrderActionPageState extends State<OrderActionPage> {
  bool isEdit = false;
  String? selectedItem;

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
  final phoneNumberController = TextEditingController();

  List<Client> _listClient = [];

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      startDate = DateTime.parse(widget.order!.tanggalMasuk ?? '');
      endDate = DateTime.parse(widget.order!.tanggalSelesai ?? '');

      pengorderController.text = widget.order!.pengorder ?? '';
      judulController.text = widget.order!.judul ?? '';
      oplahSoftCoverController.text = widget.order!.oplahSoftCover ?? '';
      oplahHardCoverController.text = widget.order!.oplahHardCover ?? '';
      oplahCoverLidahController.text = widget.order!.oplahCoverLidah ?? '';
      ukuranController.text = widget.order!.ukuran ?? '';
      kertasIsiController.text = widget.order!.kertasIsi ?? '';
      kertasCoverController.text = widget.order!.kertasCover ?? '';
      cetakIsiController.text = widget.order!.cetakIsi ?? '';
      cetakCoverController.text = widget.order!.cetakCover ?? '';
      laminasiCoverController.text = widget.order!.laminasiCover ?? '';
      finishingCoverController.text = widget.order!.finishingCover ?? '';
      phoneNumberController.text = widget.order!.phoneNumber ?? '';

      isEdit = true;
    }

    final selection = context.read<SelectionBloc>().state;
    context.read<ListClientBloc>().add(
          GetAllClient(
            selection is SelectionOffset,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListClientBloc, ListClientState>(
      listener: (context, state) {
        if (state is ListClientSuccess) {
          if (state.clients.isNotEmpty) {
            print('client: ${state.clients}');
            setState(() {
              _listClient = state.clients;
              if (!isEdit) {
                pengorderController.text = state.clients.first.name!;
              }
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.order != null ? 'Edit Order' : 'Tambah Order',
          ),
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
                  // 20.sbh(),
                  // Text(
                  //   'Status',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // 10.sbh(),
                  // //switch on off status
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 10,
                  //         vertical: 5,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: _isActivated
                  //             ? Colors.green.shade100
                  //             : Colors.red.shade100,
                  //         border: Border.all(
                  //           color: _isActivated ? Colors.green : Colors.red,
                  //           width: 1,
                  //         ),
                  //         borderRadius: 8.br(),
                  //       ),
                  //       child: Text(
                  //         _isActivated ? 'Aktif' : 'Tidak Aktif',
                  //         style: TextStyle(
                  //           color: _isActivated ? Colors.green : Colors.red,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //     10.sbw(),
                  //     Switch(
                  //       value: _isActivated,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _isActivated = value;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  20.sbh(),
                  // CustomTextField(
                  //   controller: pengorderController,
                  //   text: 'Nama Pengorder',
                  //   hintText: 'Masukkan Nama Pengorder',
                  // ),
                  Text(
                    'Nama Pengorder',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.sbh(),
                  if (_listClient.isNotEmpty)
                    DropdownButtonFormField<String>(
                      value: pengorderController.text,
                      items: _listClient.map((Client client) {
                        return DropdownMenuItem(
                          value: client.name.toString(),
                          child: Text(client.name!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          pengorderController.text = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
                  CustomTextField(
                    controller: phoneNumberController,
                    maxLines: 3,
                    text: 'Keterangan',
                    hintText: 'Masukkan Keterangan',
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
                              // _showDialog(
                              //     false, 'Semua field harus diisi', () {});
                            } else {
                              // add order
                              final format = DateFormat('yyyy-MM-dd');

                              final tanggalMasuk = format.format(startDate);

                              final tanggalSelesai = format.format(endDate);
                              final pengorder = _listClient
                                  .firstWhere(
                                    (element) =>
                                        element.name ==
                                        pengorderController.text,
                                  )
                                  .name;
                              final pengorderId = _listClient
                                  .firstWhere(
                                    (element) =>
                                        element.name ==
                                        pengorderController.text,
                                  )
                                  .id;
                              if (isEdit) {
                                context.read<OrderBloc>().add(
                                      UpdateOrder(
                                        widget.order!.copyWith(
                                          tanggalMasuk: tanggalMasuk,
                                          tanggalSelesai: tanggalSelesai,
                                          pengorder: pengorder.toString(),
                                          judul: judulController.text,
                                          oplahSoftCover:
                                              oplahSoftCoverController.text,
                                          oplahHardCover:
                                              oplahHardCoverController.text,
                                          oplahCoverLidah:
                                              oplahCoverLidahController.text,
                                          ukuran: ukuranController.text,
                                          kertasIsi: kertasIsiController.text,
                                          kertasCover:
                                              kertasCoverController.text,
                                          cetakIsi: cetakIsiController.text,
                                          cetakCover: cetakCoverController.text,
                                          laminasiCover:
                                              laminasiCoverController.text,
                                          finishingCover:
                                              finishingCoverController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                        ),
                                        pengorderId!,
                                      ),
                                    );
                              } else {
                                context.read<OrderBloc>().add(
                                      AddOrder(
                                        Order(
                                          tanggalMasuk: tanggalMasuk,
                                          tanggalSelesai: tanggalSelesai,
                                          pengorder: pengorder.toString(),
                                          judul: judulController.text,
                                          oplahSoftCover:
                                              oplahSoftCoverController.text,
                                          oplahHardCover:
                                              oplahHardCoverController.text,
                                          oplahCoverLidah:
                                              oplahCoverLidahController.text,
                                          ukuran: ukuranController.text,
                                          kertasIsi: kertasIsiController.text,
                                          kertasCover:
                                              kertasCoverController.text,
                                          cetakIsi: cetakIsiController.text,
                                          cetakCover: cetakCoverController.text,
                                          laminasiCover:
                                              laminasiCoverController.text,
                                          finishingCover:
                                              finishingCoverController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          isActive: true,
                                        ),
                                        pengorderId.toString(),
                                        context.read<SelectionBloc>().state
                                            is SelectionOffset,
                                      ),
                                    );
                              }

                              context.pop(context);

                              // BlocProvider.of<AddOrderBloc>(context).add(
                              //   AddOrderEvent(
                              //     tanggalMasuk: tanggalMasuk,
                              //     tanggalSelesai: tanggalSelesai,
                              //     pengorder: pengorderController.text,
                              //     judul: judulController.text,
                              //     oplahSoftCover: oplahSoftCoverController.text,
                              //     oplahHardCover: oplahHardCoverController.text,
                              //     oplahCoverLidah: oplahCoverLidahController.text,
                              //     ukuran: ukuranController.text,
                              //     kertasIsi: kertasIsiController.text,
                              //     kertasCover: kertasCoverController.text,
                              //     cetakIsi: cetakIsiController.text,
                              //     cetakCover: cetakCoverController.text,
                              //     laminasiCover: laminasiCoverController.text,
                              //     finishingCover: finishingCoverController.text,
                              //     phoneNumber: phoneNumberController.text,
                              //   ),
                              // );
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
                            phoneNumberController.clear();
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
