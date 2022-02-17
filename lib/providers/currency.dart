import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/currency.dart';
import 'package:moneybook/src/helper/string.dart';

Currency initialVal = Currency(currency: '¥', isPrefix: true, isSuffix: false);

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier(Currency initial) : super(initial);
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscribe;

  void unsubscribe() => _subscribe?.cancel();
  Future<void> subscribe({required String id}) async {
    if (_subscribe != null) {
      return;
    }
    final doc = getDoc();
    final id = await getShareId();
    _subscribe = doc.collection('currency').doc(id).snapshots().listen((event) {
      if (event.exists) {
        final data = event.data();
        state = Currency(
          currency: data?['currency'],
          isPrefix: data?['isPrefix'],
          isSuffix: data?['isSuffix'],
        );
      }
    });
  }

  Future<void> _update(Currency currency) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('currency').doc(id).set({
      'currency': currency.currency,
      'isPrefix': currency.isPrefix,
      'isSuffix': currency.isSuffix,
    });
  }

  Currency prevState() {
    return Currency(
      currency: state.currency,
      isPrefix: state.isPrefix,
      isSuffix: state.isSuffix,
    );
  }

  Future<void> setCurrency(
      {required String currency, required bool isPrefix}) async {
    final next = prevState();
    next
      ..currency = currency
      ..isPrefix = isPrefix
      ..isSuffix = !isPrefix;
    _update(next);
  }

  String joinCurrency(int price) {
    String strPrice = addComma(price);
    return state.isPrefix
        ? "${state.currency}$strPrice"
        : "$strPrice${state.currency}";
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
  (ref) {
    return CurrencyNotifier(initialVal);
  },
);
