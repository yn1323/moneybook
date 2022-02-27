import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/form/price_keyboard.dart';

class PriceForm extends ConsumerStatefulWidget {
  const PriceForm(
      {Key? key,
      required this.controller,
      this.label = '金額',
      this.acceptEmpty = false})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool acceptEmpty;
  @override
  _PriceForm createState() => _PriceForm();
}

class _PriceForm extends ConsumerState<PriceForm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        String? result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return PriceKeyboard(
              controller: widget.controller,
            );
          },
        );
        if (result != null) {
          widget.controller.text = result;
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: const Icon(Icons.attach_money),
          ),
          validator: (value) {
            if (!widget.acceptEmpty && (value == null || value.isEmpty)) {
              return '${widget.label}を入力してください。';
            }
            return null;
          },
        ),
      ),
    );
  }
}
