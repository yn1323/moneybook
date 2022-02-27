import 'package:moneybook/constants/index.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/src/helper/constant/color.dart';
import 'package:moneybook/src/helper/constant/icon.dart';
import 'package:moneybook/widgets/form/icon_selector.dart';

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
  IconData icon = Icons.person;
  Color color = randomColor();
  bool isExecuted = false;
  int index = 0;

  void setInitialVal(int i) {
    if (isExecuted) {
      return;
    }
    Member category = ref.read(memberProvider)[i];
    controller.text = category.label;

    setState(() {
      icon = category.icon;
      color = category.color;
      isExecuted = true;
      index = i;
    });
  }

  void iconSetter(IconData i) {
    setState(() {
      icon = i;
    });
  }

  void colorSetter(Color c) {
    setState(() {
      color = c;
    });
  }

  void add(String addItem) {
    ref
        .read(memberProvider.notifier)
        .add(Member(label: addItem, color: color, icon: icon));
  }

  void edit({int index = 0, String label = ''}) {
    ref.read(memberProvider.notifier).edit(
        index: index,
        nextMember: Member(label: label, color: color, icon: icon));
  }

  void delete(int index) {
    ref.read(memberProvider.notifier).delete(index);
  }

  void deleteConfirm(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('本当に削除しますか？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              delete(index);
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentMember = ref.watch(memberProvider);
    final isMax = currentMember.length >= maxMemberNum;

    final isEdit = ModalRoute.of(context)?.settings.name == '/member/edit';

    if (isEdit) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final i = args['index'] as int;
      setInitialVal(i);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                  IconSelector(
                    icon: icon,
                    color: color,
                    colorSetter: colorSetter,
                  ),
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
                      List<Member> clone = [...currentMember];
                      if (isEdit) {
                        clone.removeAt(index);
                      }
                      if (clone.any((element) => element.label == value)) {
                        return '同名のメンバーが存在してます。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: isEdit
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (isEdit)
                          ElevatedButton(
                            onPressed: () => deleteConfirm(index),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                            ),
                            child: const Text('削除'),
                          ),
                        if (isEdit)
                          ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                edit(index: index, label: controller.text);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('変更'),
                          ),
                        if (!isEdit)
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
