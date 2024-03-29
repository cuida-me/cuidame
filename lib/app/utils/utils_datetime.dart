import 'package:intl/intl.dart';

class UtilsDateTime {
  static DateTime? formatBrParse(String? datetime) {
    if (datetime == null) return null;
    final f = DateFormat('dd/MM/yyyy HH:mm');
    return f.parse(datetime);
  }

  static DateTime? formatToLocal(String? datetimeStr) {
    if (datetimeStr == null) return null;
    final datetime = DateTime.parse(datetimeStr);
    final datetimeLocal = datetime.toLocal();
    return datetimeLocal;
  }

  static String? toFormatBr(DateTime? datetime) {
    if (datetime == null) return null;
    final f = DateFormat('dd/MM/yyyy HH:mm');
    return f.format(datetime);
  }

  static String? toFormatGo(DateTime? datetime) {
    if (datetime == null) return null;
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    return f.format(datetime);
  }

  static String? timeString(DateTime? datetime) {
    if (datetime == null) return null;
    return '${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}h';
  }

  static bool isSameDay(DateTime? date, DateTime? dateCompare) {
    if (date == null || dateCompare == null) return false;
    var res = false;
    if (date.day == dateCompare.day && date.month == dateCompare.month && date.year == dateCompare.year) {
      res = true;
    }
    return res;
  }
}
