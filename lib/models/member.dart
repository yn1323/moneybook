import 'package:moneybook/firestore/common.dart';

List<String> initialMember = [
  'Unkown User',
];

class Member {
  Member({required this.member});
  List<String> member;

  Future<List<String>> fetch() async {
    final doc = getDoc();
    final id = await getShareId();
    try {
      final data = await doc.collection('member').doc(id).get();
      List<String> retList = data['member'].cast<String>();
      return retList;
    } catch (e) {
      return initialMember;
    }
  }

  Future<void> update() async {
    final doc = getDoc();
    final id = await getShareId();
    await doc.collection('member').doc(id).set({
      'member': member,
    });
  }
}
