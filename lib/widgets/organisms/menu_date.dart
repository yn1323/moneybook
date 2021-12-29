import 'package:moneybook/imports.dart';
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
          color: Colors.black87,
          onPressed: () {
            setNextMonth(-1);
          },
        ),
        Text(
          curretDate,
          style: const TextStyle(color: Colors.black87),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right_sharp),
          color: Colors.black87,
          onPressed: () {
            setNextMonth(1);
          },
        ),
      ],
    );
  }
}
