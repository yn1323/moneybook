import 'package:moneybook/imports.dart';

typedef StatesType = States;
StatesType initialVal = States(isLoading: false);

class States {
  States({required this.isLoading});

  bool isLoading;

  @override
  String toString() {
    return 'States(isLoading: $isLoading)';
  }
}

class StatesNotifier extends StateNotifier<StatesType> {
  StatesNotifier(StatesType initialTask) : super(initialTask);

  void setLoading(bool isLoading) {
    StatesType newState = States(isLoading: isLoading);
    state = newState;
  }
}

final statesProvider = StateNotifierProvider<StatesNotifier, StatesType>(
  (ref) {
    return StatesNotifier(initialVal);
  },
);
