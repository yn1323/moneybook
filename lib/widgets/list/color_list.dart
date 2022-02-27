import 'package:moneybook/imports.dart';
import 'package:moneybook/src/helper/constant/color.dart';

class ColorList extends StatelessWidget {
  const ColorList({
    Key? key,
    required this.colorSetter,
  }) : super(key: key);

  final Function(Color p1) colorSetter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 5,
          children: colorThemes.values
              .toList()
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RawMaterialButton(
                    onPressed: () => colorSetter(color),
                    elevation: 2.0,
                    fillColor: color,
                    child: const Text(''),
                    shape: const CircleBorder(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
