import 'package:moneybook/firestore/common.dart';

String initialCurrency = '¥';
bool initialIsPrefix = true;
bool initialIsSuffix = false;

class Currency {
  Currency(
      {required this.currency, required this.isPrefix, required this.isSuffix});

  String currency;
  bool isPrefix;
  bool isSuffix;

  Future<Currency> fetch() async {
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data = await doc.collection('currency').doc(id).get();
      return Currency(
        currency: data['currency'],
        isPrefix: data['isPrefix'],
        isSuffix: data['isSuffix'],
      );
    } catch (e) {
      return Currency(
        currency: initialCurrency,
        isPrefix: initialIsPrefix,
        isSuffix: initialIsSuffix,
      );
    }
  }

  Future<void> update() async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('currency').doc(id).set({
      'currency': currency,
      'isPrefix': isPrefix,
      'isSuffix': isSuffix,
    });
  }
}
