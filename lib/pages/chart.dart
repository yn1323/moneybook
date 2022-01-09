import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/tab_bar/calendar_tab_bar.dart';
import 'package:moneybook/widgets/util/menu_date.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/chart.dart';

class ChartPage extends ConsumerStatefulWidget {
  const ChartPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends ConsumerState<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const MenuDate(),
          bottom: TabBar(tabs: CalendarTabBar()),
        ),
        body: const TabBarView(
          children: <Widget>[
            Chart(),
            Chart(),
            Chart(),
          ],
        ),
        bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const BaseFloatingActionButton(),
      ),
    );
  }
}
