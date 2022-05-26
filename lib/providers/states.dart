import 'package:moneybook/imports.dart';
import 'package:hive/hive.dart';
import 'package:moneybook/models/state.dart';

States initialVal = States(prevCategory: '', prevMember: '', addedCount: 0);
const String hiveKey = 'states';

class StatesNotifier extends StateNotifier<States> {
  StatesNotifier(States initial) : super(initial);

  Box? box;

  Future<void> initialize() async {
    box = await Hive.openBox(hiveKey);
    if (!box!.containsKey('prevCategory')) {
      box!.put('prevCategory', '');
    }
    if (!box!.containsKey('prevMember')) {
      box!.put('prevMember', '');
    }
    if (!box!.containsKey('addedCount')) {
      box!.put('addedCount', 0);
    }
    state = States(
      prevCategory: box!.get('prevCategory'),
      prevMember: box!.get('prevMember'),
      addedCount: box!.get('addedCount'),
    );
  }

  Future<void> savePrevCategory(String prevCategory) async {
    box!.put('prevCategory', prevCategory);
    state = States(
      prevCategory: prevCategory,
      prevMember: state.prevMember,
      addedCount: state.addedCount,
    );
  }

  Future<void> savePrevMember(String prevMember) async {
    box!.put('prevMember', prevMember);
    state = States(
      prevCategory: state.prevCategory,
      prevMember: prevMember,
      addedCount: state.addedCount,
    );
  }

  Future<void> saveAddedCount(int addedCount) async {
    box!.put('addedCount', addedCount);
    state = States(
      prevCategory: state.prevCategory,
      prevMember: state.prevMember,
      addedCount: addedCount,
    );
  }
}

final statesProvider = StateNotifierProvider<StatesNotifier, States>(
  (ref) {
    return StatesNotifier(initialVal);
  },
);
