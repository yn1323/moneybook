import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/src/helper/constant/color.dart';
import 'package:moneybook/src/helper/constant/icon.dart';

class Member {
  Member({
    required this.label,
    this.color = Colors.red,
    this.icon = Icons.ac_unit,
  });

  String label;
  Color color;
  IconData icon;
}

typedef Members = List<Member>;
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
        final Members categoriesList = [];
        for (int i = 0; i < data?['member'].length; i++) {
          final defaultColor = data?['color']?[i] != null
              ? colorThemes[data?['color'][i]]
              : randomColor();
          final defaultIcon = data?['icon']?[i] != null
              ? categoryIcons[data?['icon'][i]]
              : randomIcon();
          categoriesList.add(
            Member(
              label: data?['member'][i],
              color: defaultColor as Color,
              icon: defaultIcon as IconData,
            ),
          );
        }
        state = categoriesList;
      }
    });
  }

  Future<void> _update(Members members) async {
    final doc = getDoc();
    final id = await getShareId();
    final labels = members.map((e) => e.label).toList();
    final icons = members.map((e) => getIconKey(e.icon)).toList();
    final colors = members.map((e) => getColorKey(e.color)).toList();
    await doc.collection('member').doc(id).set({
      'member': labels,
      'icon': icons,
      'color': colors,
    });
  }

  Future<void> add(Member addItem) async {
    final nextItems = [...state];
    nextItems.add(addItem);
    _update(nextItems);
  }

  Future<void> edit({int index = 0, required Member nextMember}) async {
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

  Member findByLabel(String label) {
    return state.firstWhere(
      (element) => element.label == label,
      orElse: () => Member(
          label: label, color: Colors.grey, icon: Icons.help_center_outlined),
    );
  }
}

final memberProvider = StateNotifierProvider<MemberNotifier, Members>(
  (ref) {
    return MemberNotifier(initialVal);
  },
);
