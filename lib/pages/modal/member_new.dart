import 'package:moneybook/constants/index.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';

class MemberNew extends ConsumerStatefulWidget {
  const MemberNew({
    Key? key,
  }) : super(key: key);

  @override
  _MemberNew createState() => _MemberNew();
}

class _MemberNew extends ConsumerState<MemberNew> {
  final title = '新規メンバー追加';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void add(String addItem) {
    ref.read(memberProvider.notifier).add(addItem);
  }

  @override
  Widget build(BuildContext context) {
    final currentMember = ref.watch(memberProvider);
    final isMax = currentMember.length >= maxMemberNum;

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
                    decoration: const InputDecoration(labelText: 'メンバー'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メンバーを入力してください。';
                      }
                      if (isMax) {
                        return 'メンバー数が最大です。\n既にあるメンバーを削除してください。';
                      }
                      if (currentMember.contains(value)) {
                        return '同名のメンバーが既に存在しています。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              add(controller.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('新規追加'),
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
