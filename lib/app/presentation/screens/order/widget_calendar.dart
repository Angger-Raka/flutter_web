import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    this.rangeStart,
    this.rangeEnd,
    super.key,
  });

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
    return TableCalendar(
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
      onDaySelected: (selectedDay, focusedDay) {
        // if (!isSameDay(_selectedDay, selectedDay)) {
        //   setState(() {
        //     _selectedDay = selectedDay;
        //     _focusedDay = focusedDay;
        //     _rangeStart = null; // Important to clean those
        //     _rangeEnd = null;
        //     _rangeSelectionMode = RangeSelectionMode.toggledOff;
        //   });
        // }
      },
      onRangeSelected: (start, end, focusedDay) {
        // setState(() {
        //   _selectedDay = null;
        //   _focusedDay = focusedDay;
        //   _rangeStart = start;
        //   _rangeEnd = end;
        //   _rangeSelectionMode = RangeSelectionMode.toggledOn;
        // });
      },
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
        rangeStartDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   // Tentukan tanggal masuk, tanggal selesai, dan tanggal saat ini
//   DateTime entryDate = DateTime(2024, 9, 1);
//   DateTime finishDate = DateTime(2024, 9, 25);
//   DateTime currentDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TableCalendar(
//         firstDay: DateTime(2020),
//         lastDay: DateTime(2030),
//         focusedDay: currentDate,
//         calendarBuilders: CalendarBuilders(
//           // Gaya untuk tanggal tertentu
//           markerBuilder: (context, date, events) {
//             if (date == entryDate) {
//               return _buildMarker(date, Colors.green); // Tanggal masuk
//             } else if (date == finishDate) {
//               return _buildMarker(date, Colors.red); // Tanggal selesai
//             } else if (date.day == currentDate.day &&
//                 date.month == currentDate.month &&
//                 date.year == currentDate.year) {
//               return _buildMarker(date, Colors.yellow); // Tanggal saat ini
//             }
//             return null; // Tidak ada penanda
//           },
//         ),
//         selectedDayPredicate: (day) {
//           return isSameDay(currentDate, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             currentDate = focusedDay;
//           });
//         },
//         calendarStyle: CalendarStyle(
//           markerDecoration: BoxDecoration(
//             shape: BoxShape.circle,
//           ),
//         ),
//       ),
//     );
//   }

//   // Fungsi untuk membuat lingkaran dengan warna
//   Widget _buildMarker(DateTime date, Color color) {
//     return Center(
//       child: Container(
//         width: 25,
//         height: 25,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: Text(
//             date.day.toString(),
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
