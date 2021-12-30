import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';
import 'package:moneybook/providers/screen.dart';
import 'package:moneybook/widgets/organisms/menu_date.dart';
import 'package:moneybook/widgets/parts/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/parts/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/category.dart';
import 'package:moneybook/widgets/templates/config.dart';
import 'package:moneybook/widgets/templates/chart.dart';
import 'package:moneybook/widgets/templates/list_daily.dart';
import 'package:moneybook/widgets/templates/list_monthly.dart';
import 'package:moneybook/widgets/templates/list_weekly.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String title = 'TITLE';

  void initializeDb() {
    ref.read(currencyProvider.notifier).initialize();
    ref.read(idProvider.notifier).initialize();
  }

  @override
  void initState() {
    super.initState();
    initializeDb();
  }

  Widget getBody(int index) {
    switch (index) {
      case 3:
        return const Category();
      case 4:
      default:
        return const Config();
    }
  }

  Widget getHomeTab() {
    return const TabBarView(
      children: <Widget>[
        ListMonthly(),
        ListWeekly(),
        ListDaily(),
      ],
    );
  }

  Widget getChartTab() {
    return const TabBarView(
      children: <Widget>[
        Chart(),
        Chart(),
        Chart(),
      ],
    );
  }

  Widget getAppTitle(int navigationIndex) {
    if (navigationIndex == 0 || navigationIndex == 1) {
      return const MenuDate();
    } else if (navigationIndex == 3) {
      return const Text('カテゴリー');
    } else {
      return const Text('設定');
    }
  }

  Widget getScaffold() {
    int navigationIndex = ref.watch(screenProvider).index;
    bool isHome = navigationIndex == 0;
    bool isChart = navigationIndex == 1;
    bool showTab = navigationIndex == 0 || navigationIndex == 1;
    return Scaffold(
      appBar: AppBar(
        title: getAppTitle(navigationIndex),
        bottom: showTab
            ? TabBar(
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "月別",
                      style: TextStyle(color: Colors.grey[50]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '週別',
                      style: TextStyle(color: Colors.grey[50]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '日別',
                      style: TextStyle(color: Colors.grey[50]),
                    ),
                  )
                ],
              )
            : null,
      ),
      body: isHome
          ? getHomeTab()
          : isChart
              ? getChartTab()
              : getBody(navigationIndex),
      bottomNavigationBar: BaseBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    int navigationIndex = ref.watch(screenProvider).index;
    bool showTab = navigationIndex == 0 || navigationIndex == 1;
    return showTab
        ? DefaultTabController(length: 3, child: getScaffold())
        : getScaffold();
  }
}
