import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/screen.dart';
import 'package:moneybook/providers/config_list.dart';
import 'package:moneybook/widgets/templates/base_appbar.dart';
import 'package:moneybook/widgets/templates/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/templates/base_floating_actionbutton.dart';

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
    ref.read(configListProvider.notifier).init();
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return const Text("hoge0");
      case 1:
        return const Text("hoge1");
      case 2:
        return const Text("hoge2");
      case 3:
      default:
        return const Text("hoge3");
    }
  }

  @override
  Widget build(BuildContext context) {
    int navigationIndex =
        ref.watch(screenProvider.select((value) => value.index));

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BaseAppBar(),
      ),
      body: getBody(navigationIndex),
      bottomNavigationBar: BaseBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),
    );
  }
}
