import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/providers/filter.dart';

final monthlyCashList = Provider<List<Cash>>((ref) {
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;

  final filterCategory = ref.watch(filterProvider).category;
  final filterMember = ref.watch(filterProvider).member;

  List<Cash> list = ref.read(cashProvider.notifier).filterCashList(
        year: date.year,
        month: date.month,
        category: filterCategory,
        member: filterMember,
      );
  return list;
});
