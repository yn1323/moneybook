typedef CashList = List<Cash>;

class Cash {
  Cash({
    required this.id,
    required this.category,
    required this.member,
    required this.date,
    required this.price,
    required this.memo,
    this.diffDateFromPrev = false,
  });

  String id;
  String category;
  String member;
  DateTime date;
  String memo;
  int price;
  bool diffDateFromPrev = false;

  @override
  String toString() {
    String d = date.toString();
    String p = price.toString();
    return "id: $id, price: $p, category: $category, member: $member, data: $d, memo: $memo, diffDateFromPrev: $diffDateFromPrev";
  }
}
