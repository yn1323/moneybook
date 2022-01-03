import 'package:moneybook/imports.dart';
import 'package:moneybook/models/category.dart';
import 'package:moneybook/pages/category.dart';
import 'package:moneybook/pages/home.dart';
import 'package:moneybook/providers/screen.dart';

class BottomIcon {
  BottomIcon({
    required this.label,
    required this.icon,
    required this.show,
    required this.path,
    required this.instance,
  });

  final String label;
  final IconData icon;
  final bool show;
  final String path;
  final dynamic instance;
}

class BaseBottomNavigationBar extends StatefulWidget {
  const BaseBottomNavigationBar({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  final int tabIndex;

  @override
  _BaseBottomNavigationBarState createState() =>
      _BaseBottomNavigationBarState();
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
  final List<BottomIcon> icons = [
    BottomIcon(
      label: '家計簿',
      icon: Icons.home,
      show: true,
      path: '/',
      instance: const Home(),
    ),
    BottomIcon(
      label: 'グラフ',
      icon: Icons.insert_chart_outlined_rounded,
      show: true,
      path: '/',
      instance: const Home(),
    ),
    BottomIcon(
      label: '',
      icon: Icons.add,
      show: false,
      path: '/',
      instance: const Home(),
    ),
    BottomIcon(
      label: 'カテゴリー',
      icon: Icons.category,
      show: true,
      path: '/category',
      instance: const CategoryPage(),
    ),
    BottomIcon(
      label: '設定',
      icon: Icons.settings,
      show: true,
      path: '/',
      instance: const Home(),
    ),
  ];

  void clickHandler(BuildContext context, int nextIndex) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => icons[nextIndex].instance,
        transitionDuration: const Duration(seconds: 0),
      ),
      ModalRoute.withName(icons[nextIndex].path),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tabIndex);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      fixedColor: Colors.amber[700],
      items: <BottomNavigationBarItem>[
        ...icons.map(
          (e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
          ),
        )
      ],
      currentIndex: widget.tabIndex,
      onTap: (nextIndex) {
        clickHandler(context, nextIndex);
      },
    );
  }
}
