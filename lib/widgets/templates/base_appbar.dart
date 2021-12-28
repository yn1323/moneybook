import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/atoms/button_return.dart';

class BaseAppBar extends ConsumerStatefulWidget {
  const BaseAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _BaseAppBar createState() => _BaseAppBar();
}

class _BaseAppBar extends ConsumerState<BaseAppBar> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final test = ref.watch(tmp);
    String currentRoute = ModalRoute.of(context)!.settings.name ?? '';

    return AppBar(
      title: const Text('TITLE', style: TextStyle(color: Colors.black87)),
      backgroundColor: Colors.grey[200]!,
      elevation: 1,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: () {},
          color: Colors.black87,
        ),
      ],
      leading: currentRoute == '/config' ? const ButtonReturn() : null,
    );
  }
}
