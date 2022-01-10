import 'package:moneybook/firestore/common.dart';

List<String> initialCategory = [
  '食費',
  '生活費',
  '光熱費',
];

class Category {
  Category({required this.category});
  List<String> category = initialCategory;

  Future<List<String>> fetch() async {
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data = await doc.collection('category').doc(id).get();
      List<String> retList = data['category'].cast<String>();
      return retList;
    } catch (e) {
      return initialCategory;
    }
  }

  Future<void> update() async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('category').doc(id).set({
      'category': category,
    });
  }

  List<String> getCategory() {
    return category;
  }
}
