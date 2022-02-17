import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/providers/filter.dart';

final totalPrice = Provider<String>((ref) {
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final filterCategory = ref.watch(filterProvider).category;
  final filterMember = ref.watch(filterProvider).member;

  int total = ref.read(cashProvider.notifier).filteredTotal(
      year: date.year,
      month: date.month,
      category: filterCategory,
      member: filterMember);
  String totalStr = ref.read(currencyProvider.notifier).joinCurrency(total);
  return totalStr;
});
