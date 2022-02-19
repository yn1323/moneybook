import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/budget.dart';
import 'package:moneybook/widgets/form/price_form.dart';

class ConfigBudget extends ConsumerStatefulWidget {
  const ConfigBudget({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigBudget createState() => _ConfigBudget();
}

class _ConfigBudget extends ConsumerState<ConfigBudget> {
  final String title = '目標設定';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  bool validBudget = false;

  @override
  void initState() {
    super.initState();
    Budget budget = ref.read(budgetProvider);
    setState(() {
      controller.text = budget.price.toString();
      validBudget = budget.validBudget;
    });
  }

  void update() {
    final nextBudget =
        int.parse(controller.text.isEmpty ? '0' : controller.text);
    Budget budget = Budget(price: nextBudget, validBudget: validBudget);
    ref.read(budgetProvider.notifier).update(budget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: SwitchListTile(
                      value: validBudget,
                      title: Text('予算を設定${validBudget ? 'する' : 'しない'}'),
                      onChanged: (next) {
                        setState(() => validBudget = next);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: PriceForm(
                      controller: controller,
                      label: '予算',
                      acceptEmpty: !validBudget,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              update();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('設定'),
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
