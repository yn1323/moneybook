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
    final cashList = await fetch();
    addMultipleCash(cashList);
    state = cashList;
  }

  Future<void> addOneCash(Cash cash, Box? box) async {
    box ??= await open();
    box.add(cash);
  }

  Future<void> addMultipleCash(List<Cash> cashList) async {
    Box box = await open();
    box.addAll(cashList);
  }

  Future<List<Cash>> fetch() async {
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data =
          await doc.collection('data').where('targetId', isEqualTo: id).get();
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
  }
}

final cashProvider = StateNotifierProvider<CashNotifier, CashList>(
  (ref) {
    return CashNotifier([]);
  },
);
