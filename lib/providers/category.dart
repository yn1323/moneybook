import 'package:hive/hive.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/category.dart';

Category initialVal = Category(category: initialCategory);
String hiveKey = 'category';

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier(Category initial) : super(initial);
  Box? box;

  Category prevState() {
    return Category(
      category: state.category,
    );
  }

  Future<void> initialize() async {
    box = await Hive.openBox(hiveKey);
    final categoryList = await state.fetch();
    box!.put(hiveKey, categoryList);
    state = Category(
      category: box!.get(hiveKey),
    );
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final next = prevState();
    final insertIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final item = next.category.removeAt(oldIndex);
    box = await Hive.openBox(hiveKey);
    next.category.insert(insertIndex, item);
    box!.put(hiveKey, next.category);
    state = next;
    state.update();
  }

  Future<void> add(String addItem) async {
    final nextItems = prevState().category;
    nextItems.add(addItem);
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Category(category: nextItems);
    state.update();
  }

  Future<void> edit({int index = 0, String nextCategory = ''}) async {
    final nextItems = prevState().category;
    nextItems[index] = nextCategory;
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Category(category: nextItems);
    state.update();
  }

  Future<void> delete(int index) async {
    final nextItems = prevState().category;
    nextItems.removeAt(index);
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Category(category: nextItems);
    state.update();
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, Category>(
  (ref) {
    return CategoryNotifier(initialVal);
  },
);
