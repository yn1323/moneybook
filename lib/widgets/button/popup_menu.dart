import 'package:moneybook/imports.dart';

class PopupMenu extends ConsumerStatefulWidget {
  const PopupMenu({
    Key? key,
    required this.list,
    required this.onTap,
  }) : super(key: key);

  final List<String> list;
  final Function(String) onTap;

  @override
  _PopupMenu createState() => _PopupMenu();
}

class _PopupMenu extends ConsumerState<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: '',
      itemBuilder: (_) => widget.list
          .map(
            (str) => PopupMenuItem<String>(child: Text(str), value: str),
          )
          .toList(),
      onSelected: (String str) {
        widget.onTap(str);
      },
    );
  }
}
