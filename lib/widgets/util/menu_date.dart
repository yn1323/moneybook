import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/date.dart';

class MenuDate extends ConsumerStatefulWidget {
  const MenuDate({
    Key? key,
  }) : super(key: key);

  @override
  _MenuDate createState() => _MenuDate();
}

class _MenuDate extends ConsumerState<MenuDate> {
  String curretDate = '';

  @override
  void initState() {
    super.initState();
    setCurrentDate();
  }

  void setCurrentDate() {
    setState(() {
      curretDate = ref.read(dateProvider.notifier).getYearMonth();
    });
    DateTime d = ref.read(dateProvider).date;
    ref.read(cashProvider.notifier).subscribe(year: d.year, month: d.month);
  }

  void setNextMonth(int addMonth) {
    ref.watch(dateProvider.notifier).setDate(month: addMonth);
    setCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left_sharp),
          onPressed: () {
            setNextMonth(-1);
          },
        ),
        Text(curretDate),
        IconButton(
          icon: const Icon(Icons.arrow_right_sharp),
          onPressed: () {
            setNextMonth(1);
          },
        ),
      ],
    );
  }
}
