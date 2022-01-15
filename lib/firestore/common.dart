import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

const String collectionName = 'app';
const String docName = 'moneymanage2';

String getRandomId() =>
    FirebaseFirestore.instance.collection(collectionName).doc().id;

Future<String> getShareId() async {
  final box = await Hive.openBox('userid');
  return box.get('id');
}

DocumentReference<Map<String, dynamic>> getDoc() {
  return FirebaseFirestore.instance.collection('app').doc('cashbook');
}
