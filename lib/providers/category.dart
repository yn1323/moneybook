import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/src/helper/constant/color.dart';
import 'package:moneybook/src/helper/constant/icon.dart';

class Category {
  Category({
    required this.label,
    this.color = Colors.red,
    this.icon = Icons.ac_unit,
  });

  String label;
  Color color;
  IconData icon;
}

typedef Categories = List<Category>;
Categories initialVal = [
  Category(
      label: '食費', color: Colors.red, icon: categoryIcons['lunch_dining']!),
  Category(label: '生活費', color: Colors.blue, icon: categoryIcons['grocery']!),
  Category(label: '光熱費', color: Colors.green, icon: categoryIcons['bolt']!),
];

class CategoryNotifier extends StateNotifier<Categories> {
  CategoryNotifier(Categories initial) : super(initial);
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
    _subscribe = doc.collection('category').doc(id).snapshots().listen((event) {
      if (event.exists) {
        final data = event.data();
        final Categories categoriesList = [];
        for (int i = 0; i < data?['category'].length; i++) {
          final defaultColor = data?['color']?[i] != null
              ? colorThemes[data?['color'][i]]
              : randomColor();
          final defaultIcon = data?['icon']?[i] != null
              ? categoryIcons[data?['icon'][i]]
              : randomIcon();
          categoriesList.add(
            Category(
              label: data?['category'][i],
              color: defaultColor as Color,
              icon: defaultIcon as IconData,
            ),
          );
        }
        state = categoriesList;
      }
    });
  }

  Future<void> _update(Categories categories) async {
    final doc = getDoc();
    final id = await getShareId();
    final labels = categories.map((e) => e.label).toList();
    final icons = categories.map((e) => getIconKey(e.icon)).toList();
    final colors = categories.map((e) => getColorKey(e.color)).toList();
    await doc.collection('category').doc(id).set({
      'category': labels,
      'icon': icons,
      'color': colors,
    });
  }

  Future<void> add(Category addItem) async {
    final nextItems = [...state];
    nextItems.add(addItem);
    _update(nextItems);
  }

  Future<void> edit({int index = 0, required Category nextCategory}) async {
    final nextItems = [...state];
    nextItems[index] = nextCategory;
    _update(nextItems);
  }

  Future<void> reorder(Categories nextItems) async {
    _update(nextItems);
  }

  Future<void> delete(int index) async {
    final nextItems = [...state];
    nextItems.removeAt(index);
    _update(nextItems);
  }

  Category findByLabel(String label) {
    return state.firstWhere(
      (element) => element.label == label,
      orElse: () => Category(
          label: label, color: Colors.grey, icon: Icons.help_center_outlined),
    );
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, Categories>(
  (ref) {
    return CategoryNotifier(initialVal);
  },
);
