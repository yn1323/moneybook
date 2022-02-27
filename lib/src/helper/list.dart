import 'package:moneybook/models/cash.dart';

List<dynamic> reorderList(
    {required List<dynamic> list,
    required int oldIndex,
    required int newIndex}) {
  final insertIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
  final removeItem = list.removeAt(oldIndex);
  list.insert(insertIndex, removeItem);
  return list;
}

int foldCashTotal(List<Cash> list) {
  return list.fold(
      0, (previousValue, element) => previousValue + element.price);
}
