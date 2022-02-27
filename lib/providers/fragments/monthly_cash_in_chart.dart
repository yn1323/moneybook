import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/src/helper/map.dart';

class ChartDataum {
  final String domain;
  final int number;
  ChartDataum({required this.domain, required this.number});
}

typedef ConfigData = Categories;

typedef ChartDatumList = List<ChartDataum>;

final monthlyCashInChart = Provider.family<ChartDatumList, String>((ref, type) {
  if (type != 'member' && type != 'category') {
    return [];
  }
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final members = ref.watch(memberProvider);
  final categories = ref.watch(categoryProvider);

  final ChartDatumList chartDatumList = [];
  Map<String, int> tempItemsMap = {};
  List<Cash> cashList = ref.read(cashProvider.notifier).filterCashList(
        year: date.year,
        month: date.month,
      );

  for (final cash in cashList) {
    final toFetch = type == 'member' ? cash.member : cash.category;
    if (tempItemsMap.keys.contains(toFetch)) {
      tempItemsMap[toFetch] = (tempItemsMap[toFetch] as int) + cash.price;
    } else {
      tempItemsMap[toFetch] = cash.price;
    }
  }
  final sortedMap = sortMap(tempItemsMap, order: 'desc');
  final keys = sortedMap.keys;

  for (final key in keys) {
    chartDatumList.add(ChartDataum(domain: key, number: sortedMap[key] as int));
  }

  if (type != 'member') {
    for (final configDataum in categories) {
      if (!keys.contains(configDataum.label)) {
        chartDatumList.add(ChartDataum(domain: configDataum.label, number: 0));
      }
    }
  } else {
    for (final configDataum in members) {
      if (!keys.contains(configDataum.label)) {
        chartDatumList.add(ChartDataum(domain: configDataum.label, number: 0));
      }
    }
  }

  return chartDatumList;
});
