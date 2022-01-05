import 'package:hive/hive.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/member.dart';

Member initialVal = Member(member: initialMember);
String hiveKey = 'member';

class MemberNotifier extends StateNotifier<Member> {
  MemberNotifier(Member initial) : super(initial);
  Box? box;

  Member prevState() {
    return Member(
      member: state.member,
    );
  }

  Future<void> initialize() async {
    box = await Hive.openBox(hiveKey);
    final memberList = await state.fetch();
    box!.put(hiveKey, memberList);
    state = Member(
      member: box!.get(hiveKey),
    );
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final next = prevState();
    final insertIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final item = next.member.removeAt(oldIndex);
    box = await Hive.openBox(hiveKey);
    next.member.insert(insertIndex, item);
    box!.put(hiveKey, next.member);
    state = next;
    state.update();
  }

  Future<void> add(String addItem) async {
    final nextItems = prevState().member;
    nextItems.add(addItem);
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Member(member: nextItems);
    state.update();
  }

  Future<void> edit({int index = 0, String nextMember = ''}) async {
    final nextItems = prevState().member;
    nextItems[index] = nextMember;
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Member(member: nextItems);
    state.update();
  }

  Future<void> delete(int index) async {
    final nextItems = prevState().member;
    nextItems.removeAt(index);
    box = await Hive.openBox(hiveKey);
    box!.put(hiveKey, nextItems);
    state = Member(member: nextItems);
    state.update();
  }
}

final memberProvider = StateNotifierProvider<MemberNotifier, Member>(
  (ref) {
    return MemberNotifier(initialVal);
  },
);
