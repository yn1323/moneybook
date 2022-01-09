import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/member.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CashNew extends ConsumerStatefulWidget {
  const CashNew({
    Key? key,
  }) : super(key: key);

  @override
  _CashNew createState() => _CashNew();
}

class _CashNew extends ConsumerState<CashNew> {
  final title = '';
  final _key = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  DateTime date = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    dateController.text = formatter.format(date);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1990),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      setState(() => date = picked);
      dateController.text = formatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () => selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: '日付',
                          prefixIcon: Icon(Icons.today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '日付を入力してください。';
                          }
                          return null;
                        },
                      ),
                    ),
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
                              // add(controller.text);
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
            ElevatedButton(
                onPressed: () async {
                  var result = await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.music_note),
                            title: Text('Music'),
                            onTap: () => Navigator.of(context).pop(1),
                          ),
                          ListTile(
                            leading: Icon(Icons.videocam),
                            title: Text('Video'),
                            onTap: () => Navigator.of(context).pop(2),
                          ),
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text('Picture'),
                            onTap: () => Navigator.of(context).pop(3),
                          ),
                        ],
                      );
                    },
                  );
                  print('bottom sheet result: $result');
                },
                child: const Text('aaa'))
          ],
        ),
      ),
    );
  }
}
