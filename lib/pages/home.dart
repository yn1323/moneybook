import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/config_list.dart';
import 'package:moneybook/widgets/templates/base_appbar.dart';
import 'package:moneybook/widgets/templates/base_floating_action_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseAppBar(
        title: title,
        body: const Text("hoge"),
      ),
      floatingActionButton: const NFloatingActionButton(),
    );
  }
}
