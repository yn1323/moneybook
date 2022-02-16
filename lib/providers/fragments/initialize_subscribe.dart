import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';
import 'package:moneybook/providers/member.dart';

final initializeSubscribe = Provider((ref) {
  ref.watch(idProvider);
  print("hoge");

  // unsubscribe and subscribe again
  ref.read(currencyProvider.notifier);
  ref.read(categoryProvider.notifier);
  ref.read(memberProvider.notifier);

  // only unsubscribe
  ref.read(cashProvider.notifier);
});
