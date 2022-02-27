import 'package:flutter/material.dart';

const locale = Locale("ja", "JP");

final ColorScheme lightTheme = ColorScheme(
  primary: Colors.teal[600]!, // appBarの背景、ElevatedButtonの色など
  primaryVariant: Colors.teal[900]!,
  secondary: Colors.amber[600]!, // FloatingActionButtonの色など
  secondaryVariant: Colors.amber[800]!,
  surface: Colors.grey[200]!, // Cardの色など
  background: Colors.grey[200]!, // Scaffoldのbodyの背景色など
  error: Colors.red[600]!, // TextFormFieldのvalidation失敗時の色など
  onPrimary: Colors.grey[50]!, // ElevatedButtonのテキストの色など
  onSecondary: Colors.grey[50]!, // FloatingActionButtonのchildの色など
  onSurface: Colors.brown,
  onBackground: Colors.brown,
  onError: Colors.brown,
  brightness: Brightness.light,
);

const ColorScheme darkTheme = ColorScheme(
  primary: Colors.white,
  primaryVariant: Colors.white,
  secondary: Colors.black,
  secondaryVariant: Colors.black,
  surface: Colors.grey,
  background: Colors.grey,
  error: Colors.black,
  onPrimary: Colors.black,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);
