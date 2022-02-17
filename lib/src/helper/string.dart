import 'package:intl/intl.dart';

String addComma(int n) {
  final formatter = NumberFormat("#,###");
  var result = formatter.format(n);
  return result;
}

String dateToString({required DateTime date, String format = 'M/d'}) {
  var formatter = DateFormat(format);
  var formatted = formatter.format(date);
  return formatted;
}
