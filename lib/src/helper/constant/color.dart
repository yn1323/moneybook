import 'package:moneybook/imports.dart';

const Map<String, Color> colorThemes = {
  'red': Colors.red,
  'blue': Colors.blue,
  'green': Colors.green,
  'amber': Colors.amber,
  'deepPurple': Colors.deepPurple,
  'blurGrey': Colors.blueGrey,
  'lime': Colors.lime,
  'pink': Colors.pink,
  'brown': Colors.brown,
  'cyan': Colors.cyan,
};

Color randomColor() {
  List<Color> colors = colorThemes.values.toList();
  return (colors..shuffle()).first;
}

String getColorKey(Color c) {
  String ret = '';
  colorThemes.forEach((key, value) {
    if (value == c) {
      ret = key;
    }
  });
  return ret;
}
