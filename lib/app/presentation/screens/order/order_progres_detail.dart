import 'package:flutter/material.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:timelines/timelines.dart';

class OrderProgresDetail extends StatelessWidget {
  OrderProgresDetail({super.key});

  final _data = {
    'Pesan Kertas': 'Selesai',
    'Setting': 'Selesai',
    'CTP': 'Selesai',
    'Naik Lipat': 'Selesai',
    'Lipat/Susun/Set': 'Selesai',
    'Jahit Benang': 'Proses',
    'Jahit Kawat': 'Belum',
    'Block Lem': 'Belum',
    'Skiblat': 'Belum',
    'Potong Buku Jadi': 'Belum',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Progres Pesanan'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  10.sbw(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal masuk = 2021-09-09',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Tanggal selesai = 2021-09-09',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Pengorder = John Doe',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              10.sbh(),
              Text(
                'Oplah Soft Cover = 1',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Oplah Hard Cover = 1',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Oplah Cover Lidah = 1',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Ukuran = A4',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Kertas Isi = HVS 80',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Kertas Cover = Art Paper 230',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Cetak Isi = Full Color',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Cetak Cover = Full Color',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Laminasi Cover = Doff',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Finishing = Hot Print',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              10.sbh(),
              Text(
                'Progres Pengerjaan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: Flexible(
                  child: Timeline.tileBuilder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemCount: _data.length,
                      oppositeContentsBuilder: (context, index) {
                        return Container(
                          width: 140,
                          child: Center(
                            child: Text(
                              _data.keys.elementAt(index),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      contentsBuilder: (context, index) {
                        final status = _data.values.elementAt(index);

                        switch (status) {
                          case 'Selesai':
                            return Card(
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Selesai',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          case 'Proses':
                            return Card(
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Proses',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          case 'Belum':
                            return Card(
                              color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Belum',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          default:
                        }
                      },
                      indicatorBuilder: (context, index) {
                        final status = _data.values.elementAt(index);

                        switch (status) {
                          case 'Selesai':
                            return DotIndicator(
                              color: Colors.green,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            );
                          case 'Proses':
                            return OutlinedDotIndicator(
                              color: Colors.blue,
                              child: Icon(
                                Icons.timer_outlined,
                                color: Colors.blue,
                              ),
                            );
                          case 'Belum':
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
                        final status = _data.values.elementAt(index);

                        switch (status) {
                          case 'Selesai':
                            return SolidLineConnector(
                              color: Colors.green,
                            );
                          case 'Proses':
                            return SolidLineConnector(
                              color: Colors.blue,
                            );
                          case 'Belum':
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
              ),
              Text(
                'Aksi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.sbh(),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back),
                    ),
                    10.sbw(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Jahit Benang'),
                      ),
                    ),
                    10.sbw(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
              10.sbh(),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(12),
                  padding: EdgeInsets.all(10),
                  isExpanded: true,
                  value: 'Selesai',
                  items: <String>['Selesai', 'Proses', 'Belum']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
              10.sbh(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
