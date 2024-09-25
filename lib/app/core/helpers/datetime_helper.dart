import 'package:intl/intl.dart';

class DatetimeHelper {
  String calculateDeadline(String deadline) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');

    // Hanya menggunakan tanggal tanpa jam, menit, detik.
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime deadlineDate = format.parse(deadline);

    int remainingDays = deadlineDate.difference(today).inDays;

    if (remainingDays > 0) {
      return 'tenggat waktu: $remainingDays hari';
    } else if (remainingDays == 0) {
      return 'Tenggat waktu hari ini';
    } else {
      return 'Tenggat telah lewat ${remainingDays.abs()} hari';
    }
  }

  DateTime parseDate(String date) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.parse(date);
  }

  String formatDateTime(DateTime dateTime) {
    // 01 Januari 2022
    DateFormat format = DateFormat('dd MMMM yyyy');
    return format.format(dateTime);
  }
}
