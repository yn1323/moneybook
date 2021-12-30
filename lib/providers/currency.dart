import 'package:moneybook/imports.dart';
import 'package:hive/hive.dart';

Currency initialVal = Currency(currency: '¥', isPrefix: true);
String hiveKey = 'currency';

class Currency {
  Currency({required this.currency, required this.isPrefix});

  String currency;
  bool isPrefix;
}

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier(Currency initial) : super(initial);
  Box? box;

  Currency prevState() {
    return Currency(
      currency: state.currency,
      isPrefix: state.isPrefix,
    );
  }

  void initialize() async {
    box = await Hive.openBox(hiveKey);
  }

  Future<void> setCurrency(
      {required String currency, required bool isPrefix}) async {
    await Future.wait([
      box!.put('currency', currency),
      box!.put('isPrefix', isPrefix),
    ]);
  }

  Currency getCurrency() => Currency(
      currency: box!.get('currency', defaultValue: initialVal.currency),
      isPrefix: box!.get('isPrefix', defaultValue: initialVal.isPrefix));
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
  (ref) {
    return CurrencyNotifier(initialVal);
  },
);
