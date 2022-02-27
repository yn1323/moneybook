import 'package:moneybook/imports.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    Key? key,
    required this.fillColor,
    required this.icon,
    required this.size,
  }) : super(key: key);

  final Color fillColor;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        color: fillColor,
      ),
      child: Icon(
        icon,
        color: Colors.grey[200],
        size: size,
      ),
    );
  }
}
