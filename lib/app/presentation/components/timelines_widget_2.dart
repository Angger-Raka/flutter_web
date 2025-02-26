import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/app/presentation/components/card_order.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines/timelines.dart';

class TimelinesWidget2 extends StatefulWidget {
  const TimelinesWidget2({
    super.key,
    required this.title,
    required this.list,
  });

  final String title;
  final List<Stage> list;

  @override
  State<TimelinesWidget2> createState() => _TimelinesWidget2State();
}

class _TimelinesWidget2State extends State<TimelinesWidget2> {
  List<Stage> _data = [];

  @override
  void initState() {
    _data = widget.list;
    super.initState();
  }

  void showUpdateDialog(
    BuildContext context,
    int index,
    Stage stage,
    List<String> statuses,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Status',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apakah Anda yakin ingin mengubah status menjadi',
              ),
              DropdownButton<String>(
                value: stage.statusStep,
                items: statuses
                    .map(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    //update _data
                    _data[index].statusStep = value;
                    context.read<StepBloc>().add(
                          UpdateStep(
                            id: stage.id.toString(),
                            status: value ?? '',
                          ),
                        );
                  });
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Timeline.tileBuilder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: widget.list.length,
                oppositeContentsBuilder: (context, index) {
                  return Container(
                    width: 140,
                    child: Center(
                      child: Text(
                        // _data.keys.elementAt(index),
                        _data[index].namaStep ?? '',
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
                  // final status = _data.values.elementAt(index);
                  final status = _data[index].statusStep ?? '';
                  Color? color;
                  String? text;

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
                      showUpdateDialog(
                        context,
                        index,
                        _data[index],
                        ['Selesai', 'Sedang Dikerjakan', 'Belum Dikerjakan'],
                      );
                    },
                    child: Card(
                      color: color,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text ?? '',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                indicatorBuilder: (context, index) {
                  // final status = _data.values.elementAt(index);
                  final status = _data[index].statusStep ?? '';

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
                  // final status = _data.values.elementAt(index);
                  final status = _data[index].statusStep ?? '';

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
    );
  }
}
