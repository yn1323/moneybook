import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/screen.dart';

class BottomIcon {
  BottomIcon({required this.label, required this.icon, required this.show});

  final String label;
  final IconData icon;
  final bool show;
}

class BaseBottomNavigationBar extends HookConsumerWidget {
  BaseBottomNavigationBar({Key? key}) : super(key: key);

  final List<BottomIcon> icons = [
    BottomIcon(label: '家計簿', icon: Icons.home, show: true),
    BottomIcon(
        label: 'グラフ', icon: Icons.insert_chart_outlined_rounded, show: true),
    BottomIcon(label: '', icon: Icons.add, show: false),
    BottomIcon(label: 'カテゴリー', icon: Icons.category, show: true),
    BottomIcon(label: '設定', icon: Icons.settings, show: true),
  ];

  int getCurrentIndex(WidgetRef ref) {
    return ref.watch(screenProvider).index;
  }

  void clickHandler(WidgetRef ref, int nextIndex) {
    ref.read(screenProvider.notifier).setIndex(nextIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      currentIndex: getCurrentIndex(ref),
      onTap: (nextIndex) {
        clickHandler(ref, nextIndex);
      },
    );
  }
}
