import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';

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
    final categories = ref.watch(memberProvider).member;
    return ReorderableListView(
      children: categories
          .map(
            (member) => ListTile(
              key: Key(member),
              title: Text(member),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/member/edit',
                            arguments: {
                              'index': categories.indexOf(member),
                              'member': member
                            });
                      },
                      icon: const Icon(Icons.edit)),
                  ReorderableDragStartListener(
                    index: categories.indexOf(member),
                    child: const Icon(Icons.drag_handle),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onReorder: (int prev, int next) {
        ref.read(memberProvider.notifier).reorder(prev, next);
      },
    );
  }
}
