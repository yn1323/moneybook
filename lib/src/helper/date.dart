import 'package:intl/intl.dart';

bool isSunday({required DateTime date}) {
  final String weekDayShort = DateFormat('E').format(date);
  return weekDayShort == 'Sun';
}

bool isSaturDay({required DateTime date}) {
  final String weekDayShort = DateFormat('E').format(date);
  return weekDayShort == 'Sat';
}
