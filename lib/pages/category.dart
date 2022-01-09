import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/tab_bar/category_tab_bar.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/category.dart';
import 'package:moneybook/widgets/templates/member.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends ConsumerState<CategoryPage>
    with SingleTickerProviderStateMixin {
  String title = 'カテゴリー';
  int tabIndex = 0;

  void showNewModal() {
    final String targetPath = tabIndex == 0 ? '/category/new' : '/member/new';
    Navigator.of(context).pushNamed(targetPath);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => showNewModal(),
            )
          ],
          title: Text(title),
          bottom: TabBar(
            tabs: CategoryTabBar(),
            onTap: (index) => setState(() => tabIndex = index),
          ),
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
