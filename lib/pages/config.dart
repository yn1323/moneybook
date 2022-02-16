import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/fragments/initialize_subscribe.dart';
import 'package:moneybook/widgets/util/base_bottom_navigationbar.dart';
import 'package:moneybook/widgets/util/base_floating_actionbutton.dart';
import 'package:moneybook/widgets/templates/config.dart';

class ConfigPage extends ConsumerStatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigPage createState() => _ConfigPage();
}

class _ConfigPage extends ConsumerState<ConfigPage> {
  String title = '設定';

  @override
  Widget build(BuildContext context) {
    ref.watch(initializeSubscribe);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Config(),
      bottomNavigationBar: const BaseBottomNavigationBar(tabIndex: 4),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),
    );
  }
}
