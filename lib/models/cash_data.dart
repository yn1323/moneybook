class CashDataModel {
  CashDataModel(
      {required this.category,
      required this.date,
      required this.member,
      required this.memo,
      required this.price,
      required this.targetId});

  String category;
  DateTime date;
  String member;
  String memo;
  int price;
  String targetId;
}
