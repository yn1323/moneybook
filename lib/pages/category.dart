import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/atoms/category_tab_bar.dart';
import 'package:moneybook/widgets/parts/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/parts/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/category.dart';
import 'package:moneybook/widgets/templates/member.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends ConsumerState<CategoryPage> {
  String title = 'カテゴリー';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // actions: appBarActions(navIndex: navigationIndex, tabIndex: tabIndex),
          title: Text(title),
          bottom: TabBar(tabs: CategoryTabBar()),
        ),
        body: const TabBarView(
          children: <Widget>[
            Category(),
            Member(),
          ],
        ),
        bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 3),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const BaseFloatingActionButton(),
      ),
    );
  }
}
