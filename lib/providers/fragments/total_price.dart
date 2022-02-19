import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/providers/filter.dart';

class TotalPrice {
  int priceNum;
  String priceStr;
  TotalPrice({required this.priceNum, required this.priceStr});
}

final totalPrice = Provider.family<TotalPrice, DateTime?>((ref, d) {
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final filterCategory = ref.watch(filterProvider).category;
  final filterMember = ref.watch(filterProvider).member;

  int total = ref.read(cashProvider.notifier).filteredTotal(
      year: d != null ? d.year : date.year,
      month: d != null ? d.month : date.month,
      category: filterCategory,
      member: filterMember);
  String totalStr = ref.read(currencyProvider.notifier).joinCurrency(total);
  return TotalPrice(priceNum: total, priceStr: totalStr);
});
