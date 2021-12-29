import 'package:moneybook/imports.dart';

Currency initialVal = Currency(currency: '', isPrefix: false);

class Currency {
  Currency({required this.currency, required this.isPrefix});
  String currency;
  bool isPrefix;
}

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier(Currency initial) : super(initial);

  Currency prevState() {
    return Currency(
      currency: state.currency,
      isPrefix: state.isPrefix,
    );
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
  (ref) {
    return CurrencyNotifier(initialVal);
  },
);
