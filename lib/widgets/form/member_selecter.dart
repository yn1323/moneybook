import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';

class MemberSelecter extends ConsumerStatefulWidget {
  const MemberSelecter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  @override
  _MemberSelecter createState() => _MemberSelecter();
}

class _MemberSelecter extends ConsumerState<MemberSelecter> {
  @override
  Widget build(BuildContext context) {
    final members = ref.watch(memberProvider);
    final hasMember = members.isNotEmpty;
    if (!hasMember && widget.controller.text.isEmpty) {
      return Container();
    }

    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        String? result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: members
                    .map(
                      (member) => ListTile(
                        title: Text(member.label),
                        onTap: () => Navigator.of(context).pop(member.label),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
        if (result != null) {
          widget.controller.text = result;
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: '支払',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
