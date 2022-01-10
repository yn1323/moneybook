import 'package:moneybook/imports.dart';

class KeyboardLabel {
  KeyboardLabel({
    required this.label,
    required this.type,
  });
  final Widget label;
  final String type;
}

Widget textLabel(String str) => Text(str, style: const TextStyle(fontSize: 20));
Widget iconlabel(IconData icons) => Icon(icons, size: 30);

final List<KeyboardLabel> keyboardKeys = [
  KeyboardLabel(type: '7', label: textLabel('7')),
  KeyboardLabel(type: '8', label: textLabel('8')),
  KeyboardLabel(type: '9', label: textLabel('9')),
  KeyboardLabel(type: 'del', label: iconlabel(Icons.backspace)),
  KeyboardLabel(type: '4', label: textLabel('4')),
  KeyboardLabel(type: '5', label: textLabel('5')),
  KeyboardLabel(type: '6', label: textLabel('6')),
  KeyboardLabel(type: '', label: textLabel('')),
  KeyboardLabel(type: '1', label: textLabel('1')),
  KeyboardLabel(type: '2', label: textLabel('2')),
  KeyboardLabel(type: '3', label: textLabel('3')),
  KeyboardLabel(type: '', label: textLabel('')),
  KeyboardLabel(type: '', label: textLabel('')),
  KeyboardLabel(type: '0', label: textLabel('0')),
  KeyboardLabel(type: '', label: textLabel('')),
  KeyboardLabel(type: 'ok', label: textLabel('完了')),
];

class PriceKeyboard extends ConsumerStatefulWidget {
  const PriceKeyboard({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceKeyboardState();
}

class _PriceKeyboardState extends ConsumerState<PriceKeyboard> {
  void clickHandler(String type) {
    final val = widget.controller.text;
    if (type == '') {
      return;
    } else if (type == 'ok') {
      Navigator.of(context).pop();
    } else if (type == 'del') {
      if (val.isNotEmpty) {
        widget.controller.text = val.substring(0, val.length - 1);
      }
    } else {
      if (val.length < 10) {
        widget.controller.text = val + type;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1.5,
      // padding: const EdgeInsets.all(1.0),
      // mainAxisSpacing: 1.0,
      // crossAxisSpacing: 1.0,
      children: keyboardKeys
          .map(
            (e) => Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: AbsorbPointer(
                  absorbing: e.type.isEmpty,
                  child: TextButton(
                    onPressed: () {
                      clickHandler(e.type);
                      // print(e.label);
                      // print(val);
                    },
                    child: e.label,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
