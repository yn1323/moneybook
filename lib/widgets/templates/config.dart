import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/budget.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';

class ConfigList {
  ConfigList({required this.label, required this.trailing, required this.path});

  final String label;
  final String trailing;
  final String path;
}

class Config extends ConsumerStatefulWidget {
  const Config({
    Key? key,
  }) : super(key: key);

  @override
  _Config createState() => _Config();
}

String budgetText(WidgetRef ref) {
  final budget = ref.watch(budgetProvider);
  final priceStr =
      ref.read(currencyProvider.notifier).joinCurrency(budget.price);

  return budget.validBudget ? priceStr : '設定しない';
}

class _Config extends ConsumerState<Config> {
  List<ConfigList> getConfigList({
    String id = '',
    String currency = '',
    String budget = '',
  }) {
    return [
      ConfigList(label: '共有ID', trailing: id, path: '/config/id'),
      ConfigList(label: '通貨設定', trailing: currency, path: '/config/currency'),
      ConfigList(label: '予算設定', trailing: budget, path: '/config/budget'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(idProvider);
    final currency = ref.watch(currencyProvider).currency;
    final budget = budgetText(ref);
    final configList =
        getConfigList(id: id, currency: currency, budget: budget);

    return ListView.separated(
      itemCount: configList.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(configList[index].label),
          onTap: () {
            Navigator.of(context).pushNamed(configList[index].path);
          },
          trailing: Text(configList[index].trailing),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
