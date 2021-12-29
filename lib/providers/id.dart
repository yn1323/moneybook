import 'package:moneybook/imports.dart';

String initialVal = '';

class IdNotifier extends StateNotifier<String> {
  IdNotifier(String initial) : super(initial);
}

final idProvider = StateNotifierProvider<IdNotifier, String>(
  (ref) {
    return IdNotifier(initialVal);
  },
);
