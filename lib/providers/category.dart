import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';

typedef Categories = List<String>;
Categories initialVal = [
  '食費',
  '生活費',
  '光熱費',
];

class CategoryNotifier extends StateNotifier<Categories> {
  CategoryNotifier(Categories initial) : super(initial);
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscribe;

  void unsubscribe() => _subscribe?.cancel();
  Future<void> subscribe({required String id}) async {
    if (_subscribe != null) {
      return;
    }
    final doc = getDoc();
    final id = await getShareId();
    _subscribe = doc.collection('category').doc(id).snapshots().listen((event) {
      final data = event.data();
      if (data?['category']) {
        state = data?['category'].cast<String>();
      }
    });
  }

  Future<void> _update(Categories category) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('category').doc(id).set({
      'category': category,
    });
  }

  Future<void> add(String addItem) async {
    final nextItems = [...state];
    nextItems.add(addItem);
    _update(nextItems);
  }

  Future<void> edit({int index = 0, String nextCategory = ''}) async {
    final nextItems = [...state];
    nextItems[index] = nextCategory;
    _update(nextItems);
  }

  Future<void> delete(int index) async {
    final nextItems = [...state];
    nextItems.removeAt(index);
    _update(nextItems);
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, Categories>(
  (ref) {
    return CategoryNotifier(initialVal);
  },
);
