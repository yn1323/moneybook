import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';
import 'package:moneybook/providers/member.dart';

final initializeSubscribe = Provider((ref) {
  final id = ref.watch(idProvider);

  // unsubscribe and subscribe again
  ref.read(currencyProvider.notifier).unsubscribe();
  ref.read(categoryProvider.notifier).unsubscribe();
  ref.read(memberProvider.notifier).unsubscribe();

  ref.read(currencyProvider.notifier).subscribe(id: id);
  ref.read(categoryProvider.notifier).subscribe(id: id);
  ref.read(memberProvider.notifier).subscribe(id: id);

  // only unsubscribe
  ref.read(cashProvider.notifier).unsubscribeAll();
});
