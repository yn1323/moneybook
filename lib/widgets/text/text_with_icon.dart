import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/shape/circle_icon.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key? key,
    required this.fillColor,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Color fillColor;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: CircleIcon(
            fillColor: fillColor,
            icon: icon,
            size: 24,
          ),
        ),
        Text(text),
      ],
    );
  }
}
