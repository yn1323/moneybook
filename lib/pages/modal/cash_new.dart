import 'package:moneybook/firestore/common.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/states.dart';
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
  bool isExecuted = false;

  @override
  void initState() {
    super.initState();
  }

  void dateSetter(DateTime d) {
    setState(() => dt = d);
  }

  void deleteConfirm(String? id) {
    if (id == null) {
      return;
    }
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
              delete(id);
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

  void delete(String id) {
    ref.read(cashProvider.notifier).delete(id);
  }

  void setInitialVal(String? id) {
    if (isExecuted) return;

    if (id != null) {
      try {
        Cash? cash = ref.read(cashProvider.notifier).findCashById(id);
        if (cash == null) {
          throw Error;
        }
        memberController.text = cash.member;
        categoryController.text = cash.category;
        priceController.text = cash.price.toString();
        memoController.text = cash.memo;
        dateSetter(cash.date);
      } catch (e) {
        print(e);
      }
    }
    setState(() => isExecuted = true);
  }

  void setPreviousVal() {
    final states = ref.read(statesProvider);
    memberController.text = states.prevMember != '' ? states.prevMember : '';
    categoryController.text =
        states.prevCategory != '' ? states.prevCategory : '';
  }

  void saveCurrentSelection(bool isEdit) {
    if (isEdit) return;
    final statesFunc = ref.read(statesProvider.notifier);
    statesFunc.savePrevCategory(categoryController.text);
    statesFunc.savePrevMember(memberController.text);
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
    } else {
      setPreviousVal();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
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
                    MemoForm(controller: memoController, focusNode: focusNode),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isEdit
                              ? ElevatedButton(
                                  onPressed: () => deleteConfirm(id),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: const Text('削除'),
                                )
                              : Container(),
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_key.currentState!.validate()) {
                                saveCurrentSelection(isEdit);
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
    );
  }
}
