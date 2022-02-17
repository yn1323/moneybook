import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/date.dart';
import 'package:moneybook/widgets/button/popup_menu.dart';
import 'package:moneybook/widgets/util/menu_date.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';

class DebugPage extends ConsumerStatefulWidget {
  const DebugPage({
    Key? key,
  }) : super(key: key);

  @override
  _DebugPage createState() => _DebugPage();
}

class _DebugPage extends ConsumerState<DebugPage> {
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateProvider).date;
    ref.watch(cashProvider);
    final data = ref
        .watch(cashProvider.notifier)
        .filterCashList(year: date.year, month: date.month);

    return Scaffold(
      appBar: AppBar(
        title: const MenuDate(),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int i) => Card(
                child: ListTile(
                  title: Text(data[i].toString()),
                  subtitle: const Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: PopupMenu(
                    list: const ['編集', '削除'],
                    onTap: (str) {
                      if (str == '編集') {
                        Navigator.of(context).pushNamed(
                          '/cash/edit',
                          arguments: {"id": data[i].id, "date": data[i].date},
                        );
                      }
                      if (str == '削除') {
                        ref.read(cashProvider.notifier).delete(data[i].id);
                      }
                    },
                  ),
                  isThreeLine: true,
                ),
              ),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: data.length),
      bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),
    );
  }
}
