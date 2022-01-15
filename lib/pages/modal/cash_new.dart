import 'package:moneybook/firestore/common.dart';
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

  void add(String? id) {
    final cash = Cash(
      id: id ??= getRandomId(),
      category: categoryController.text,
      member: memberController.text,
      date: dt,
      price: int.parse(priceController.text),
      memo: memoController.text,
    );
    ref.read(cashProvider.notifier).create(cash);
  }

  void setInitialVal(String? id) {
    if (id != null) {
      try {
        Cash cash = ref.watch(cashProvider).firstWhere((cash) => cash.id == id);
        memberController.text = cash.member;
        categoryController.text = cash.category;
        priceController.text = cash.price.toString();
        memoController.text = cash.memo;
        dateSetter(cash.date);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = ModalRoute.of(context)?.settings.name == '/cash/edit';
    String? id;
    DateTime currentDate = DateTime.now();

    if (isEdit) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      id = args['id'] as String;
      currentDate = args['date'] as DateTime;
      setInitialVal(id);
    }

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
                        initialDate: currentDate,
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
                                  add(id);
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
