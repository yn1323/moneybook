import 'package:moneybook/imports.dart';
import 'package:hive/hive.dart';
import 'package:moneybook/models/currency.dart';

Currency initialVal = Currency(currency: '¥', isPrefix: true, isSuffix: false);
String hiveKey = 'currency';

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier(Currency initial) : super(initial);
  Box? box;

  Currency prevState() {
    return Currency(
      currency: state.currency,
      isPrefix: state.isPrefix,
      isSuffix: state.isSuffix,
    );
  }

  Future<void> initialize() async {
    box = await Hive.openBox(hiveKey);
    box!.clear();
    final initial = await state.fetch();
    box!.put('currency', initial.currency);
    box!.put('isPrefix', initial.isPrefix);
    box!.put('isSuffix', initial.isSuffix);
    state = Currency(
      currency: box!.get('currency'),
      isPrefix: box!.get('isPrefix'),
      isSuffix: box!.get('isSuffix'),
    );
  }

  Future<void> setCurrency(
      {required String currency, required bool isPrefix}) async {
    await Future.wait([
      box!.put('currency', currency),
      box!.put('isPrefix', isPrefix),
      box!.put('isSuffix', !isPrefix),
    ]);
    final next = prevState();
    next
      ..currency = currency
      ..isPrefix = isPrefix
      ..isSuffix = !isPrefix;
    state = next;
    state.update();
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
  (ref) {
    return CurrencyNotifier(initialVal);
  },
);
