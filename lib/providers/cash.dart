import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';

typedef CashList = List<Cash>;
const String hiveKey = 'data';

class CashNotifier extends StateNotifier<CashList> {
  CashNotifier(CashList initial) : super([]);

  Future<Box> open() async {
    return await Hive.openBox<Cash>(hiveKey);
  }

  Future<void> initialize() async {
    Box box = await open();
    box.clear();
    final currentDate = DateTime.now();
    final cashList =
        await fetch(year: currentDate.year, month: currentDate.month);
    state = cashList;
  }

  Future<void> addOneCash(Cash cash, Box? box) async {
    box ??= await open();
    box.add(cash);
    if (state.every((element) => element.id != cash.id)) {
      state = [...state, cash];
    }
  }

  Future<void> addMultipleCash(List<Cash> cashList) async {
    Box box = await open();
    box.addAll(cashList);
    List<Cash> noDupliteList = cashList.where((cash) {
      return state.every((element) => element.id != cash.id);
    }).toList();
    state = [...state, ...noDupliteList];
  }

  Future<void> deleteOneCash(String cashId, Box? box) async {
    box ??= await open();
    List<Cash> newState = [...state];
    box.delete(newState.firstWhere((element) => element.id == cashId));
    state = newState.where((Cash element) => element.id != cashId).toList();
  }

  Future<List<Cash>> fetch({int year = 2022, int month = 1}) async {
    DateTime dateFrom = DateTime(year, month, 1);
    DateTime dateTo = DateTime(year, month + 1, 1);
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data = await doc
          .collection('data')
          .where('targetId', isEqualTo: id)
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime(dateFrom.year, dateFrom.month, 1))
          .where('date', isLessThan: DateTime(dateTo.year, dateTo.month, 1))
          .get();
      List<Cash> cashList = data.docs.map((e) {
        final d = e.data();
        return Cash(
          id: e.id,
          category: d['category'],
          member: d['member'],
          date: d['date'].toDate(),
          price: d['price'],
          memo: d['memo'],
        );
      }).toList();
      addMultipleCash(cashList);
      return cashList;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> create(Cash newCash) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('data').doc(newCash.id).set({
      'category': newCash.category,
      'date': Timestamp.fromDate(newCash.date),
      'member': newCash.member,
      'memo': newCash.memo,
      'price': newCash.price,
      'targetId': id,
    });
    addOneCash(newCash, null);
  }

  Future<void> delete(String cashId) async {
    final doc = getDoc();
    await doc.collection('data').doc(cashId).delete();
    deleteOneCash(cashId, null);
  }

  List<Cash> filterCashList({int year = 2022, int month = 1}) {
    DateTime dateFrom = DateTime(year, month, 1);
    DateTime dateTo = DateTime(year, month + 1, 1);

    List<Cash> data = state
        .where(
            (cash) => cash.date.isAfter(dateFrom) && cash.date.isBefore(dateTo))
        .toList();
    return data;
  }
}

final cashProvider = StateNotifierProvider<CashNotifier, CashList>(
  (ref) {
    return CashNotifier([]);
  },
);
