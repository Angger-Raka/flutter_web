import 'package:flutter/material.dart';
import 'package:flutter_web/app/core/extensions/num_extension.dart';
import 'package:intl/intl.dart'; // Package untuk format tanggal
import 'package:table_calendar/table_calendar.dart'; // Package untuk kalender

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  bool isShowProgress = false;

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List with Calendar'),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          DateTime dateIn = DateTime.now().subtract(Duration(days: index * 2));
          DateTime dateOut = DateTime.now().add(Duration(days: index * 3));
          Duration remaining = dateOut.difference(DateTime.now());

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ExpansionTile(
                title: Text(
                  'JUDUL ORDERAN',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onExpansionChanged: (isExpanded) {
                  if (isExpanded) {
                    // print('Expanded');
                  } else {
                    // print('Collapsed');
                    setState(() {
                      isShowProgress = false;
                    });
                  }
                },
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer: Nama Customer',
                    ),
                    Text(
                      'Phone: 081234567890',
                    ),
                    Text(
                      'Tanggal Masuk: ${DateFormat('dd MMM yyyy').format(dateIn)}',
                    ),
                    Text(
                      'Tanggal Selesai: ${DateFormat('dd MMM yyyy').format(dateOut)}',
                    ),
                  ],
                ),
                children: [
                  isSmallScreen
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
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
                                      for (String detail in _detailOrder)
                                        Text(
                                          '$detail: isi detail',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Waktu Tersisa: ${remaining.inDays} hari',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  CalendarPage(
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
                                  ? Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.grey[200],
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
                                      color: isShowProgress
                                          ? Colors.red
                                          : Colors.blue,
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
          );
        },
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    this.width,
    this.height,
    this.rangeStart,
    this.rangeEnd,
    super.key,
  });

  final double? width;
  final double? height;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime kFirstDay = DateTime(2020, 10, 16);
  DateTime kLastDay = DateTime(2030, 3, 14);

  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _rangeStart = widget.rangeStart;
    _rangeEnd = widget.rangeEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        weekendDays: [DateTime.sunday],
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.black,
          ),
          weekendStyle: TextStyle(
            color: Colors.red,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {},
        onRangeSelected: (start, end, focusedDay) {},
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          rangeStartDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          rangeEndDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          todayDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
