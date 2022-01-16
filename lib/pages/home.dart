import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/tab_bar/calendar_tab_bar.dart';
import 'package:moneybook/widgets/util/menu_date.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/list_cash.dart';
import 'package:moneybook/widgets/templates/list_monthly.dart';
import 'package:moneybook/widgets/templates/list_daily.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const MenuDate(),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () => Navigator.of(context).pushNamed('/filter'),
            )
          ],
          bottom: TabBar(tabs: CalendarTabBar()),
        ),
        body: const TabBarView(
          children: <Widget>[
            ListCash(),
            ListDaily(),
            ListMonthly(),
          ],
        ),
        bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 0),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const BaseFloatingActionButton(),
      ),
    );
  }
}
