import 'package:moneybook/imports.dart';
import 'package:hive/hive.dart';

String initialVal = 'initialId';
String hiveKey = 'userid';

class IdNotifier extends StateNotifier<String> {
  IdNotifier(String initial) : super(initial);

  Box? box;

  void initialize() async {
    box = await Hive.openBox(hiveKey);
    if (!box!.containsKey('id')) {
      box!.put('id', initialVal);
      box!.put('initialId', initialVal);
    }
  }

  String getId() => box!.get('id');
  String getInitialId() => box!.get('initialId');

  Future<void> setId({required String id}) async {
    await Future.wait([
      box!.put('id', id),
    ]);
  }
}

final idProvider = StateNotifierProvider<IdNotifier, String>(
  (ref) {
    return IdNotifier(initialVal);
  },
);
