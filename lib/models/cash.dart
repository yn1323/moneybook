typedef CashList = List<Cash>;

class Cash {
  Cash({
    required this.category,
    required this.member,
    required this.date,
    required this.price,
    required this.memo,
  });

  String category;
  String member;
  DateTime date;
  String memo;
  int price;
}
