import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/src/helper/map.dart';

class CashMember {
  final String memberName;
  final int price;
  CashMember({required this.memberName, required this.price});
}

typedef CashMemberList = List<CashMember>;

final monthlyCashByMember = Provider<CashMemberList>((ref) {
  ref.watch(cashProvider);
  final date = ref.watch(dateProvider).date;
  final configMembers = ref.watch(memberProvider);
  final CashMemberList cashMemberList = [];
  Map<String, int> itemsMap = {};
  List<Cash> cashList = ref.read(cashProvider.notifier).filterCashList(
        year: date.year,
        month: date.month,
      );

  for (final cash in cashList) {
    if (itemsMap.keys.contains(cash.member)) {
      itemsMap[cash.member] = (itemsMap[cash.member] as int) + cash.price;
    } else {
      itemsMap[cash.member] = cash.price;
    }
  }
  final sortedMap = sortMap(itemsMap, order: 'desc');
  final keys = sortedMap.keys;

  for (final key in keys) {
    cashMemberList
        .add(CashMember(memberName: key, price: sortedMap[key] as int));
  }

  for (final configMember in configMembers) {
    if (!keys.contains(configMember)) {
      cashMemberList.add(CashMember(memberName: configMember, price: 0));
    }
  }

  return cashMemberList;
});
