import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/src/helper/map.dart';

class CashCategory {
  final String categoryName;
  final int price;
  CashCategory({required this.categoryName, required this.price});
}

typedef CashCategoryList = List<CashCategory>;

final monthlyCashByCategory = Provider<CashCategoryList>((ref) {
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final configCategories = ref.watch(categoryProvider);
  final CashCategoryList cashCategoryList = [];
  Map<String, int> itemsMap = {};
  List<Cash> cashList = ref.read(cashProvider.notifier).filterCashList(
        year: date.year,
        month: date.month,
      );

  for (final cash in cashList) {
    if (itemsMap.keys.contains(cash.category)) {
      itemsMap[cash.category] = (itemsMap[cash.category] as int) + cash.price;
    } else {
      itemsMap[cash.category] = cash.price;
    }
  }
  final sortedMap = sortMap(itemsMap, order: 'desc');
  final keys = sortedMap.keys;

  for (final key in keys) {
    cashCategoryList
        .add(CashCategory(categoryName: key, price: sortedMap[key] as int));
  }

  for (final configCategory in configCategories) {
    if (!keys.contains(configCategory)) {
      cashCategoryList
          .add(CashCategory(categoryName: configCategory, price: 0));
    }
  }

  return cashCategoryList;
});
