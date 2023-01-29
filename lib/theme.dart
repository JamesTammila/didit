import 'package:flutter/material.dart';

final themeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    scrolledUnderElevation: 0,
    titleSpacing: 10,
  ),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontSize: 16,
    ),
  ),
  cardTheme: const CardTheme(
    clipBehavior: Clip.hardEdge,
    elevation: 5,
  ),
);