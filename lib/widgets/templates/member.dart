import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/src/helper/list.dart';

class Member extends ConsumerStatefulWidget {
  const Member({
    Key? key,
  }) : super(key: key);

  @override
  _Member createState() => _Member();
}

class _Member extends ConsumerState<Member> {
  @override
  Widget build(BuildContext context) {
    final members = ref.watch(memberProvider);
    return ReorderableListView(
      children: members
          .map(
            (member) => ListTile(
              key: Key(members.indexOf(member).toString()),
              title: Text(member.label),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/member/edit',
                            arguments: {
                              'index': members.indexOf(member),
                              'member': member
                            });
                      },
                      icon: const Icon(Icons.edit)),
                  ReorderableDragStartListener(
                    index: members.indexOf(member),
                    child: const Icon(Icons.drag_handle),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onReorder: (int prev, int next) {
        final list = reorderList(list: members, oldIndex: prev, newIndex: next)
            as Members;
        ref.read(memberProvider.notifier).reorder(list);
      },
    );
  }
}
