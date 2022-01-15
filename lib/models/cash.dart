import 'package:hive/hive.dart';
part 'cash.g.dart';

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

  @HiveField(0)
  String id;

  @HiveField(1)
  String category;

  @HiveField(2)
  String member;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String memo;

  @HiveField(5)
  int price;

  @override
  String toString() {
    String d = date.toString();
    String p = price.toString();
    return "id: $id, price: $p, category: $category, member: $member, data: $d, memo: $memo";
  }
}
