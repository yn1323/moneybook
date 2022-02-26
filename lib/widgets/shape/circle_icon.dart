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
    return AbsorbPointer(
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 2.0,
        fillColor: fillColor,
        child: Icon(
          icon,
          color: Colors.grey[200],
          size: size,
        ),
        padding: const EdgeInsets.all(10.0),
        shape: const CircleBorder(),
      ),
    );
  }
}
