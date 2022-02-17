import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';

typedef Members = List<String>;
Members initialVal = [];

class MemberNotifier extends StateNotifier<Members> {
  MemberNotifier(Members initial) : super(initial);
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
    _subscribe = doc.collection('member').doc(id).snapshots().listen((event) {
      if (event.exists) {
        final data = event.data();
        state = data?['member'].cast<String>();
      }
    });
  }

  Future<void> _update(Members member) async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('member').doc(id).set({
      'member': member,
    });
  }

  Future<void> add(String addItem) async {
    final nextItems = [...state];
    nextItems.add(addItem);
    _update(nextItems);
  }

  Future<void> edit({int index = 0, String nextMember = ''}) async {
    final nextItems = [...state];
    nextItems[index] = nextMember;
    _update(nextItems);
  }

  Future<void> reorder(Members nextItems) async {
    _update(nextItems);
  }

  Future<void> delete(int index) async {
    final nextItems = [...state];
    nextItems.removeAt(index);
    _update(nextItems);
  }
}

final memberProvider = StateNotifierProvider<MemberNotifier, Members>(
  (ref) {
    return MemberNotifier(initialVal);
  },
);
