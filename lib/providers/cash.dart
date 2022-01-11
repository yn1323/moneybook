import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';

typedef CashList = List<Cash>;
const String hiveKey = 'data';

class CashNotifier extends StateNotifier<CashList> {
  CashNotifier(CashList initial) : super([]);

  Future<void> initialize() async {
    Box box = await Hive.openBox(hiveKey);
    // final categoryList = await state.fetch();
    // box.put(hiveKey, categoryList);
    // state = Category(
    //   category: box.get(hiveKey),
    // );
  }

  Future<List<Cash>> fetch() async {
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data =
          await doc.collection('data').where('targetId', isEqualTo: id).get();
      List<Cash> list = data.docs.map((e) {
        final d = e.data();
        return Cash(
          category: d['category'],
          member: d['member'],
          date: d['date'].toDate(),
          price: d['price'],
          memo: d['memo'],
        );
      }).toList();

      print('data@@@@');
      // print(list[0].date);
      return [];
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> create(Cash newCash) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('data').add({
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
