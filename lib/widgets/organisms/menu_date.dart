import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/states.dart';

class MenuDate extends HookConsumerWidget {
  const MenuDate({Key? key}) : super(key: key);

  void setNextMonth(WidgetRef ref, int addMonth) {
    ref.watch(statesProvider.notifier).setDate(month: addMonth);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime date = ref.watch(statesProvider).date;
    String currentDate = ref.read(statesProvider.notifier).getYearMonth(date);
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            setNextMonth(ref, -1);
          },
          child: Text('-'),
        ),
        Text(currentDate),
        ElevatedButton(
          onPressed: () {
            setNextMonth(ref, 1);
          },
          child: Text('+'),
        ),
      ],
    );
  }
}
