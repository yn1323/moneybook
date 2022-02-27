import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';

typedef CashList = List<Cash>;
typedef AllCashList = Map<String, CashList>;

class CashNotifier extends StateNotifier<AllCashList> {
  CashNotifier(AllCashList initial) : super({});
  Map<String, StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
      _subscribes = {};

  Cash getOneCash({int year = 2022, int month = 1, String id = 'id'}) {
    String dateStr = _dateStr(year: year, month: month);
    List<Cash> list = state[dateStr] ?? [];
    return list.firstWhere((element) => element.id == id);
  }

  String _dateStr({int year = 2022, int month = 1, int? day}) =>
      '$year-$month${day != null ? '-$day' : ''}';
  bool _isSubscribing({int year = 2022, int month = 1}) =>
      _subscribes.keys.contains(_dateStr(year: year, month: month));

  void unsubscribeAll() {
    _subscribes.forEach((k, _) => _subscribes[k]?.cancel());
    state = {};
    _subscribes = {};
  }

  Future<void> _subscribe(
      {int year = 2022,
      int month = 1,
      required void Function(QuerySnapshot<Map<String, dynamic>>)?
          onData}) async {
    final dateStr = _dateStr(year: year, month: month);

    if (_subscribes.keys.contains(dateStr)) {
      return;
    }

    final doc = getDoc();
    final id = await getShareId();
    DateTime dateFrom = DateTime(year, month, 1);
    DateTime dateTo = DateTime(year, month + 1, 1);
    _subscribes[dateStr] = doc
        .collection('data')
        .where('targetId', isEqualTo: id)
        .where("date",
            isGreaterThanOrEqualTo: DateTime(dateFrom.year, dateFrom.month, 1))
        .where('date', isLessThan: DateTime(dateTo.year, dateTo.month, 1))
        .orderBy("date", descending: true)
        .snapshots()
        .listen(onData);
  }

  Cash? findCashById(String id) {
    for (CashList list in state.values) {
      if (list.any((element) => element.id == id)) {
        return list.firstWhere((element) => element.id == id);
      }
    }
  }

  void Function(QuerySnapshot<Map<String, dynamic>>) setCash(
      {int year = 2022, int month = 1}) {
    final dateStr = _dateStr(year: year, month: month);
    String prevDateStr = '';

    return (data) {
      CashList list = data.docs.map((e) {
        final d = e.data();
        final DateTime oneDateTime = d['date'].toDate();
        final String oneDateStr = _dateStr(
            year: oneDateTime.year,
            month: oneDateTime.month,
            day: oneDateTime.day);
        final bool diffDateFromPrev = prevDateStr != oneDateStr;
        prevDateStr = oneDateStr;
        return Cash(
          id: e.id,
          category: d['category'],
          member: d['member'],
          date: oneDateTime,
          price: d['price'],
          memo: d['memo'],
          diffDateFromPrev: diffDateFromPrev,
        );
      }).toList();
      final AllCashList newState = Map.from(state);
      newState[dateStr] = list;
      state = newState;
    };
  }

  void subscribe({int year = 2022, int month = 1}) async {
    if (_isSubscribing(year: year, month: month)) {
      return;
    }
    try {
      await _subscribe(
          year: year, month: month, onData: setCash(year: year, month: month));
    } catch (e) {
      print("cash provider subscribe error");
      print(e);
    }
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
  }

  Future<void> delete(String cashId) async {
    final doc = getDoc();
    await doc.collection('data').doc(cashId).delete();
  }

  CashList filterCashList({
    int year = 2022,
    int month = 1,
    String category = '',
    String member = '',
  }) {
    DateTime dateFrom = DateTime(year, month, 1);
    DateTime dateTo = DateTime(year, month + 1, 1);
    String dateStr = '$year-$month';
    CashList list = state[dateStr] ?? [];

    CashList data = list.where((cash) {
      if (!cash.date.isAfter(dateFrom) || !cash.date.isBefore(dateTo)) {
        return false;
      }
      if (category.isNotEmpty && cash.category != category) {
        return false;
      }
      if (member.isNotEmpty && cash.member != member) {
        return false;
      }

      return true;
    }).toList();
    return data;
  }

  int filteredTotal({
    int year = 2022,
    int month = 1,
    String category = '',
    String member = '',
  }) {
    CashList list = filterCashList(
        year: year, month: month, category: category, member: member);

    int totalPrice =
        list.fold(0, (previousValue, cash) => previousValue + cash.price);

    return totalPrice;
  }
}

final cashProvider = StateNotifierProvider<CashNotifier, AllCashList>(
  (ref) {
    return CashNotifier({});
  },
);
