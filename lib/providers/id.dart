import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:hive/hive.dart';

String initialVal = '';
String hiveKey = 'userid';

class IdNotifier extends StateNotifier<String> {
  IdNotifier(String initial) : super(initial);

  Box? box;

  Future<void> initialize() async {
    box = await Hive.openBox(hiveKey);
    if (!box!.containsKey('id')) {
      final randomId = getRandomId();
      box!.put('id', randomId);
      box!.put('initialId', randomId);
    }
    state = box!.get('id');
  }

  String getInitialId() => box!.get('initialId');

  Future<void> setId({required String id}) async {
    await Future.wait([
      box!.put('id', id),
    ]);
    state = id;
  }
}

final idProvider = StateNotifierProvider<IdNotifier, String>(
  (ref) {
    return IdNotifier(initialVal);
  },
);
