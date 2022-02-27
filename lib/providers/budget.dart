import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';

Budget initialVal = Budget(validBudget: false, price: 50000);

class Budget {
  Budget({required this.validBudget, required this.price});
  bool validBudget;
  int price;
}

class BudgetNotifier extends StateNotifier<Budget> {
  BudgetNotifier(Budget initial) : super(initial);
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscribe;

  void unsubscribe() {
    state = initialVal;
    _subscribe?.cancel();
    _subscribe = null;
  }

  Future<void> subscribe({required String id}) async {
    if (_subscribe != null) {
      return;
    }
    final doc = getDoc();
    final id = await getShareId();
    _subscribe = doc.collection('budget').doc(id).snapshots().listen((event) {
      if (event.exists) {
        final data = event.data();
        state = Budget(
          validBudget: data?['validBudget'],
          price: data?['price'],
        );
      }
    });
  }

  Future<void> update(Budget budget) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('budget').doc(id).set({
      'validBudget': budget.validBudget,
      'price': budget.price,
    });
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, Budget>(
  (ref) {
    return BudgetNotifier(initialVal);
  },
);
