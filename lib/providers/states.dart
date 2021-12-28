import 'package:moneybook/imports.dart';
import 'package:dart_date/dart_date.dart';

typedef StatesType = States;
StatesType initialVal = States(isLoading: false);

class States {
  States({required this.isLoading});

  bool isLoading;
  DateTime date = DateTime.now();

  @override
  String toString() {
    return 'States(isLoading: $isLoading)';
  }
}

class StatesNotifier extends StateNotifier<StatesType> {
  StatesNotifier(StatesType initialTask) : super(initialTask);

  States prevState() {
    return States(
      isLoading: state.isLoading,
    );
  }

  void setLoading(bool isLoading) {
    state = prevState()..isLoading = isLoading;
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

  String getYearMonth(DateTime d) {
    return '${d.getYear}年 ${d.getMonth}月';
  }
}

final statesProvider = StateNotifierProvider<StatesNotifier, StatesType>(
  (ref) {
    return StatesNotifier(initialVal);
  },
);
