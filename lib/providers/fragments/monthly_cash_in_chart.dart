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

typedef ChartDatumList = List<ChartDataum>;

final monthlyCashInChart = Provider.family<ChartDatumList, String>((ref, type) {
  if (type != 'member' && type != 'category') {
    return [];
  }
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final configData =
      ref.watch(type == 'member' ? memberProvider : categoryProvider);

  final ChartDatumList chartDatumList = [];
  Map<String, int> tempItemsMap = {};
  List<Cash> cashList = ref.read(cashProvider.notifier).filterCashList(
        year: date.year,
        month: date.month,
      );

  for (final cash in cashList) {
    final toFetch = type == 'member' ? cash.member : cash.category;
    if (tempItemsMap.keys.contains(cash.member)) {
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

  for (final configDataum in configData) {
    if (!keys.contains(configDataum)) {
      chartDatumList.add(ChartDataum(domain: configDataum, number: 0));
    }
  }

  return chartDatumList;
});