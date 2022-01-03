import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/screen.dart';
import 'package:moneybook/widgets/atoms/calendar_tab_bar.dart';
import 'package:moneybook/widgets/atoms/category_tab_bar.dart';
import 'package:moneybook/widgets/organisms/menu_date.dart';
import 'package:moneybook/widgets/parts/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/parts/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/category.dart';
import 'package:moneybook/widgets/templates/config.dart';
import 'package:moneybook/widgets/templates/chart.dart';
import 'package:moneybook/widgets/templates/list_daily.dart';
import 'package:moneybook/widgets/templates/list_monthly.dart';
import 'package:moneybook/widgets/templates/list_weekly.dart';
import 'package:moneybook/widgets/templates/member.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String title = 'TITLE';

  @override
  void initState() {
    super.initState();
  }

  Widget getHomeBody() {
    return const TabBarView(
      children: <Widget>[
        ListMonthly(),
        ListWeekly(),
        ListDaily(),
      ],
    );
  }

  Widget getChartBody() {
    return const TabBarView(
      children: <Widget>[
        Chart(),
        Chart(),
        Chart(),
      ],
    );
  }

  Widget getCategoryBody() {
    return const TabBarView(
      children: <Widget>[
        Category(),
        Member(),
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

  List<Widget> appBottom(int navIndex) {
    if (navIndex == 0 || navIndex == 1) {
      return CalendarTabBar();
    } else if (navIndex == 3) {
      return CategoryTabBar();
    } else {
      return [];
    }
  }

  List<Widget> appBarActions({int navIndex = 0, int tabIndex = 0}) {
    final routeName = ModalRoute.of(context)!.settings.name;
    bool isCategory = routeName == '/category';
    bool isMember = routeName == '/member';
    String callbackPage = isCategory ? '/category/new' : '/member/new';

    if (!isCategory || !isMember) {
      return [];
    }

    return [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(callbackPage);
        },
      )
    ];
  }

  Widget getBody(int navIndex) {
    bool isHome = navIndex == 0;
    bool isChart = navIndex == 1;
    bool isCategory = navIndex == 3;

    if (isHome) {
      return getHomeBody();
    } else if (isChart) {
      return getChartBody();
    } else if (isCategory) {
      return getCategoryBody();
    } else {
      return const Config();
    }
  }

  Widget getScaffold({dynamic tabIndex = 0}) {
    int navigationIndex = ref.watch(screenProvider).index;
    bool showTab =
        navigationIndex == 0 || navigationIndex == 1 || navigationIndex == 3;
    return Scaffold(
      appBar: AppBar(
        // actions: appBarActions(navIndex: navigationIndex, tabIndex: tabIndex),
        title: getAppTitle(navigationIndex),
        bottom: showTab ? TabBar(tabs: appBottom(navigationIndex)) : null,
      ),
      body: getBody(navigationIndex),
      bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    int navigationIndex = ref.watch(screenProvider).index;
    bool showTab =
        navigationIndex == 0 || navigationIndex == 1 || navigationIndex == 3;
    bool isCategory = navigationIndex == 3;
    return showTab
        ? DefaultTabController(
            length: isCategory ? 2 : 3,
            child: getScaffold(tabIndex: DefaultTabController.of(context)))
        : getScaffold();
  }
}
