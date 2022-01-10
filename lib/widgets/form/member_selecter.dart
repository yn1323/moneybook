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
    final members = ref.read(memberProvider).getMember();
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        String? result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: members
                  .map(
                    (member) => ListTile(
                      title: Text(member),
                      onTap: () => Navigator.of(context).pop(member),
                    ),
                  )
                  .toList(),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '支払い者を入力してください。';
            }
            return null;
          },
        ),
      ),
    );
  }
}
