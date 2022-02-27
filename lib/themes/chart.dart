import 'package:moneybook/imports.dart';

const List<MaterialColor> originalChartThemes = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.amber,
  Colors.deepPurple,
  Colors.blueGrey,
  Colors.lime,
  Colors.pink,
  Colors.brown,
  Colors.cyan,
];

List<Color> chartThemes(int number) =>
    originalChartThemes.map((e) => e[number]!).toList();
