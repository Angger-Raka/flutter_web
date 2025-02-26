import 'package:flutter/material.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:timelines/timelines.dart';

class Progress {
  final String title;
  final Status status;

  Progress({required this.title, required this.status});
}

enum Status { selesai, sedangDikerjakan, belumSelesai }

class TimelineWidget extends StatelessWidget {
  final String judul;
  final List<Progress> progressList;

  const TimelineWidget({
    Key? key,
    required this.judul,
    required this.progressList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            indicatorTheme: IndicatorThemeData(
              size: 20,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: progressList.length,
            // itemBuilder: (context, index) {
            //   final progress = progressList[index];
            //   return _buildTimelineTile(progress);
            // },
            connectorBuilder: (context, index, type) {
              return SolidLineConnector(
                color: _getColor(progressList[index].status),
              );
            },
            indicatorBuilder: (context, index) {
              return DotIndicator(
                color: _getColor(progressList[index].status),
              );
            },
          ),
        ),
      ],
    );
  }

  // TimelineTile _buildTimelineTile(Progress progress) {
  //   return TimelineTile(
  //     indicatorStyle: IndicatorStyle(
  //       indicator: Icon(
  //         _getIcon(progress.status),
  //         color: _getColor(progress.status),
  //         size: 20,
  //       ),
  //     ),
  //     contents: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             progress.title,
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //           ),
  //           Text(
  //             _statusToString(progress.status),
  //             style: TextStyle(color: Colors.grey[600]),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Color _getColor(Status status) {
    switch (status) {
      case Status.selesai:
        return Colors.green;
      case Status.sedangDikerjakan:
        return Colors.orange;
      case Status.belumSelesai:
        return Colors.red;
    }
  }

  IconData _getIcon(Status status) {
    switch (status) {
      case Status.selesai:
        return Icons.check_circle;
      case Status.sedangDikerjakan:
        return Icons.timelapse;
      case Status.belumSelesai:
        return Icons.circle_outlined;
    }
  }

  String _statusToString(Status status) {
    switch (status) {
      case Status.selesai:
        return 'Selesai';
      case Status.sedangDikerjakan:
        return 'Sedang Dikerjakan';
      case Status.belumSelesai:
        return 'Belum Selesai';
    }
  }
}

class StatusTimeline extends StatefulWidget {
  @override
  _StatusTimelineState createState() => _StatusTimelineState();
}

class _StatusTimelineState extends State<StatusTimeline> {
  final List<String> _statuses = [
    'Selesai',
    'Sedang Dikerjakan',
    'Belum Selesai'
  ];
  int _currentStatusIndex = 0;

  void _changeStatus(int index) {
    setState(() {
      _currentStatusIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          child: Timeline.tileBuilder(
            scrollDirection: Axis.horizontal,
            builder: TimelineTileBuilder.connected(
              connectorBuilder: (_, index, __) => SolidLineConnector(
                color: index <= _currentStatusIndex ? Colors.blue : Colors.grey,
              ),
              indicatorBuilder: (_, index) => DotIndicator(
                color: index <= _currentStatusIndex ? Colors.blue : Colors.grey,
              ),
              itemExtent: 100.0,
              itemCount: _statuses.length,
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _statuses.length,
            (index) => Column(
              children: [
                Text(_statuses[index]),
                ElevatedButton(
                  onPressed: () => _changeStatus(index),
                  child: Text("Ubah ke ${_statuses[index]}"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
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
    return Container(
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
    );
  }
}

// class ProcessWidget extends StatefulWidget {
//   ProcessWidget({
//     this.process,
//     super.key,
//   });

//   final Process? process;

//   @override
//   State<ProcessWidget> createState() => _ProcessWidgetState();
// }

// class _ProcessWidgetState extends State<ProcessWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final steps = widget.process?.steps;

//     var listStatust = steps?.map((e) => e.statusStep).toList();

//     void _showDialog(
//       bool isSuccess,
//       String text,
//       Function afterDismiss,
//     ) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             icon: isSuccess
//                 ? Icon(
//                     Icons.check_circle_outline_rounded,
//                     color: Colors.green,
//                     size: 50,
//                   )
//                 : Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 50,
//                   ),
//             title: isSuccess
//                 ? Text(
//                     'Berhasil',
//                     style: TextStyle(
//                       color: Colors.green,
//                     ),
//                   )
//                 : Text(
//                     'Gagal',
//                     style: TextStyle(
//                       color: Colors.red,
//                     ),
//                   ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       ).then(
//         (value) => afterDismiss(),
//       );
//     }

//     Future<void> _showUpdateStep(
//       int id,
//       String status,
//     ) async {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(
//             'Update',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Container(
//             width: 200,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Update Progress for Order 1',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 6.sbh(),
//                 SizedBox(
//                   width: double.maxFinite,
//                   child: DropdownButton<String>(
//                     value: status,
//                     items: [
//                       "Belum Dikerjakan",
//                       "Sedang Dikerjakan",
//                       "Selesai",
//                     ]
//                         .map((e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       context.read<UpdateStepBloc>().add(
//                             UpdateStep(
//                               id: id.toString(),
//                               status: value ?? '',
//                             ),
//                           );
//                       context.read<ListOrderBloc>().add(GetAllOrder());
//                       Navigator.pop(context);
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     return BlocListener<StepBloc, StepState>(
//       listener: (context, state) {
//         if (state is UpdateStepSuccess) {
//           _showDialog(
//             true,
//             'Data berhasil diupdate',
//             () => context.read<ListOrderBloc>().add(GetAllOrder()),
//           );
//         } else if (state is UpdateStepFailure) {
//           _showDialog(
//             false,
//             'Data gagal diupdate',
//             () => context.read<ListOrderBloc>().add(GetAllOrder()),
//           );
//         }
//       },
//       child: Container(
//         height: 150,
//         width: double.maxFinite,
//         padding: EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.process?.namaProses ?? '',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Flexible(
//                     child: Timeline.tileBuilder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       builder: TimelineTileBuilder.connected(
//                         connectionDirection: ConnectionDirection.before,
//                         itemCount: steps?.length ?? 0,
//                         oppositeContentsBuilder: (context, index) {
//                           return Container(
//                             width: 140,
//                             child: Center(
//                               child: Text(
//                                 steps?.elementAt(index).namaStep ?? '',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         contentsBuilder: (context, index) {
//                           final status = steps?.elementAt(index).statusStep;
//                           Color color = Colors.red;
//                           String text = '';

//                           switch (status) {
//                             case 'Selesai':
//                               color = Colors.green;
//                               text = 'Selesai';
//                               break;

//                             case 'Sedang Dikerjakan':
//                               color = Colors.blue;
//                               text = 'Proses';
//                               break;

//                             case 'Belum Dikerjakan':
//                               color = Colors.red;
//                               text = 'Belum';
//                               break;

//                             default:
//                           }

//                           return InkWell(
//                             onTap: () {
//                               _showUpdateStep(
//                                 steps?.elementAt(index).id ?? 0,
//                                 steps?.elementAt(index).statusStep ?? '',
//                               );
//                             },
//                             child: Card(
//                               color: color,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   text,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         indicatorBuilder: (context, index) {
//                           final status = steps?.elementAt(index).statusStep;

//                           switch (status) {
//                             case 'Selesai':
//                               return DotIndicator(
//                                 color: Colors.green,
//                                 child: Icon(
//                                   Icons.check,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             case 'Sedang Dikerjakan':
//                               return OutlinedDotIndicator(
//                                 color: Colors.blue,
//                                 child: Icon(
//                                   Icons.timer_outlined,
//                                   color: Colors.blue,
//                                 ),
//                               );
//                             case 'Belum Dikerjakan':
//                               return OutlinedDotIndicator(
//                                 color: Colors.red,
//                                 child: Icon(
//                                   Icons.close,
//                                   color: Colors.red,
//                                 ),
//                               );
//                             default:
//                               return OutlinedDotIndicator(
//                                 color: Colors.red,
//                                 child: Icon(
//                                   Icons.close,
//                                   color: Colors.red,
//                                 ),
//                               );
//                           }
//                         },
//                         connectorBuilder: (context, index, type) {
//                           final status = steps?.elementAt(index).statusStep;

//                           switch (status) {
//                             case 'Selesai':
//                               return SolidLineConnector(
//                                 color: Colors.green,
//                               );
//                             case 'Sedang Dikerjakan':
//                               return SolidLineConnector(
//                                 color: Colors.blue,
//                               );
//                             case 'Belum Dikerjakan':
//                               return SolidLineConnector(
//                                 color: Colors.red,
//                               );
//                             default:
//                               return SolidLineConnector(
//                                 color: Colors.red,
//                               );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
