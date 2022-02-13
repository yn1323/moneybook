import 'package:intl/intl.dart';

String addComma(int n) {
  final formatter = NumberFormat("#,###");
  var result = formatter.format(n);
  return result;
}
