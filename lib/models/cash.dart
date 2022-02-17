import 'package:hive/hive.dart';

typedef CashList = List<Cash>;

@HiveType(typeId: 0)
class Cash {
  Cash({
    required this.id,
    required this.category,
    required this.member,
    required this.date,
    required this.price,
    required this.memo,
  });

  String id;
  String category;
  String member;
  DateTime date;
  String memo;
  int price;

  @override
  String toString() {
    String d = date.toString();
    String p = price.toString();
    return "id: $id, price: $p, category: $category, member: $member, data: $d, memo: $memo";
  }
}
