import 'package:moneybook/imports.dart';
import 'package:dart_date/dart_date.dart';

Date initialVal = Date(date: DateTime.now());

class Date {
  Date({required this.date});
  DateTime date;
}

class DateNotifier extends StateNotifier<Date> {
  DateNotifier(Date initialTask) : super(initialTask);

  Date prevState() {
    return Date(
      date: state.date,
    );
  }

  void setDate({int year = 0, int month = 0, int week = 0, int day = 0}) {
    if (year != 0) {
      state = prevState()..date = state.date.addYears(year);
    }
    if (month != 0) {
      state = prevState()..date = state.date.addMonths(month);
    }
    if (week != 0) {
      state = prevState()..date = state.date.addWeeks(week);
    }
    if (day != 0) {
      state = prevState()..date = state.date.addDays(day);
    }
  }

  String getYearMonth() {
    return '${state.date.getYear}年 ${state.date.getMonth}月';
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, Date>(
  (ref) {
    return DateNotifier(initialVal);
  },
);
