import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/widgets/form/category_selector.dart';
import 'package:moneybook/widgets/form/date_picker.dart';
import 'package:moneybook/widgets/form/member_selecter.dart';
import 'package:moneybook/widgets/form/memo_form.dart';
import 'package:moneybook/widgets/form/price_form.dart';

class CashNew extends ConsumerStatefulWidget {
  const CashNew({
    Key? key,
  }) : super(key: key);

  @override
  _CashNew createState() => _CashNew();
}

class _CashNew extends ConsumerState<CashNew> {
  final title = '支出';
  final _key = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController memberController =
      TextEditingController(text: '');
  final TextEditingController categoryController =
      TextEditingController(text: '');
  final TextEditingController priceController = TextEditingController(text: '');
  final TextEditingController memoController = TextEditingController(text: '');
  final FocusNode focusNode = FocusNode();
  DateTime dt = DateTime.now();

  @override
  void initState() {
    super.initState();
    ref.read(cashProvider.notifier).fetch();
  }

  void dateSetter(DateTime d) {
    setState(() => dt = d);
  }

  void add() {
    final cash = Cash(
      category: categoryController.text,
      member: memberController.text,
      date: dt,
      price: int.parse(priceController.text),
      memo: memoController.text,
    );
    ref.read(cashProvider.notifier).create(cash);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DatePicker(
                        controller: dateController,
                        initialDate: DateTime.now(),
                        dateSetter: dateSetter,
                      ),
                      MemberSelecter(controller: memberController),
                      CategorySelecter(controller: categoryController),
                      PriceForm(controller: priceController),
                      MemoForm(
                          controller: memoController, focusNode: focusNode),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_key.currentState!.validate()) {
                                  add();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('保存'),
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
        ),
      ),
    );
  }
}
