import 'package:moneybook/imports.dart';

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
}

final statesProvider = StateNotifierProvider<StatesNotifier, StatesType>(
  (ref) {
    return StatesNotifier(initialVal);
  },
);
