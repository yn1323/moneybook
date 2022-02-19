import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/tab_bar/chart_tab_bar.dart';
import 'package:moneybook/widgets/templates/chart_filter_category.dart';
import 'package:moneybook/widgets/templates/chart_filter_member.dart';
import 'package:moneybook/widgets/util/menu_date.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const MenuDate(),
          bottom: TabBar(tabs: CalendarTabBar()),
        ),
        body: const TabBarView(
          children: <Widget>[
            ChartFilterCategory(),
            ChartFilterMember(),
          ],
        ),
        bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const BaseFloatingActionButton(),
      ),
    );
  }
}
