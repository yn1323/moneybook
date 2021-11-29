import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/config_list.dart';

class NFloatingActionButton extends HookConsumerWidget {
  const NFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        ref.read(configListProvider.notifier).addCard();
      },
    );
  }
}
