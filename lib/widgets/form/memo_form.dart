import 'package:moneybook/imports.dart';

class MemoForm extends ConsumerStatefulWidget {
  const MemoForm({Key? key, required this.controller, required this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _MemoForm createState() => _MemoForm();
}

class _MemoForm extends ConsumerState<MemoForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: 2,
      maxLength: 256,
      decoration: const InputDecoration(
        labelText: 'メモ',
        prefixIcon: Icon(Icons.edit_location_sharp),
      ),
    );
  }
}
