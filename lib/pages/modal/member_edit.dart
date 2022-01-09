import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';

class MemberEdit extends ConsumerStatefulWidget {
  const MemberEdit({
    Key? key,
  }) : super(key: key);

  @override
  _MemberEdit createState() => _MemberEdit();
}

class _MemberEdit extends ConsumerState<MemberEdit> {
  final title = 'メンバー編集';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void edit({int index = 0, String nextMember = ''}) {
    ref
        .read(memberProvider.notifier)
        .edit(index: index, nextMember: nextMember);
  }

  void delete(int index) {
    ref.read(memberProvider.notifier).delete(index);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final index = args['index'] as int;
    final member = args['member'] as String;
    controller.text = member;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLength: 16,
                    focusNode: focusNode,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'カテゴリー'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'カテゴリーを入力してください。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            delete(index);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                          child: const Text('削除'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              edit(index: index, nextMember: controller.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('変更'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}