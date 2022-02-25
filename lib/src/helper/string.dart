import 'package:intl/intl.dart';

String addComma(int n) {
  final formatter = NumberFormat("#,###");
  var result = formatter.format(n);
  return result;
}

String dateToString(
    {required DateTime date, String format = 'M/d', bool weekDay = false}) {
  var formatter = DateFormat(format);
  String formatted = formatter.format(date);
  final String weekday = '(${DateFormat.E('ja').format(date)})';
  if (weekDay) {
    formatted += weekday;
  }
  return formatted;
}
