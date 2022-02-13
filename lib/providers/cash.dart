import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';

typedef CashList = List<Cash>;
typedef AllCashList = Map<String, CashList>;
const String hiveKey = 'data';

class CashNotifier extends StateNotifier<AllCashList> {
  CashNotifier(AllCashList initial) : super({});
  final fetched = [];

  Cash getOneCash({int year = 2022, int month = 1, String id = 'id'}) {
    String dateStr = '$year-$month';
    List<Cash> list = state[dateStr] ?? [];
    return list.firstWhere((element) => element.id == id);
  }

  Cash? findCashById(String id) {
    for (CashList list in state.values) {
      if (list.any((element) => element.id == id)) {
        return list.firstWhere((element) => element.id == id);
      }
    }
  }

  void fetch({int year = 2022, int month = 1}) async {
    final dateStr = '$year-$month';
    if (fetched.contains('$year-$month')) {
      return;
    }
    fetched.add(dateStr);
    DateTime dateFrom = DateTime(year, month, 1);
    DateTime dateTo = DateTime(year, month + 1, 1);

    final doc = getDoc();
    final id = await getShareId();
    try {
      final ref = doc
          .collection('data')
          .where('targetId', isEqualTo: id)
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime(dateFrom.year, dateFrom.month, 1))
          .where('date', isLessThan: DateTime(dateTo.year, dateTo.month, 1))
          .orderBy("date", descending: true);
      ref.snapshots().listen((data) {
        CashList list = data.docs.map((e) {
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
        final AllCashList newState = Map.from(state);
        newState[dateStr] = list;
        state = newState;
      }, onError: (error) {
        print(error);
      });
    } catch (e) {
      print("cash provider");
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
