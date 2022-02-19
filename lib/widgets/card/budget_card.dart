import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/budget.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/total_price.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetCard extends ConsumerStatefulWidget {
  const BudgetCard({
    Key? key,
  }) : super(key: key);

  @override
  _BudgetCard createState() => _BudgetCard();
}

class _BudgetCard extends ConsumerState<BudgetCard> {
  double getPercent({required int budget, required int total}) {
    if (budget == 0 || total == 0) {
      return 0;
    }
    return budget < total ? 1 : total / budget;
  }

  barColor(double percentage) {
    if (percentage < 0.5) {
      return Colors.green[300]!;
    } else if (percentage < 0.75) {
      return Colors.yellow[600]!;
    } else if (percentage < 0.9) {
      return Colors.red[400]!;
    }
    return Colors.red[700]!;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    final join =
        (int num) => ref.read(currencyProvider.notifier).joinCurrency(num);
    final budget = ref.watch(budgetProvider);
    final d = DateTime.now();
    if (!budget.validBudget) {
      return Container();
    }
    final total = ref.watch(totalPrice(d));
    final remaining = budget.price - total.priceNum;
    final remainingStr = join(remaining);
    final percentage = getPercent(budget: budget.price, total: total.priceNum);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("今月の支出 : ${total.priceStr}"),
                  Row(children: [
                    const Text("残り: "),
                    Text(
                      remainingStr,
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            remaining < 0 ? Colors.red[700] : Colors.blue[700],
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            LinearPercentIndicator(
              animation: true,
              lineHeight: 20,
              animationDuration: 200,
              percent: percentage,
              progressColor: barColor(percentage),
            ),
          ],
        ),
      ),
    );
  }
}
