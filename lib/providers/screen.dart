import 'package:moneybook/imports.dart';

Screen initialVal = Screen(index: 0);

class Screen {
  Screen({required this.index});
  int index;
}

class ScreenNotifier extends StateNotifier<Screen> {
  ScreenNotifier(Screen initialTask) : super(initialTask);
  void setIndex(nextIndex) {
    state = Screen(index: nextIndex);
  }
}

final screenProvider = StateNotifierProvider<ScreenNotifier, Screen>(
  (ref) {
    return ScreenNotifier(initialVal);
  },
);
