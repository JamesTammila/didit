import 'package:flutter/material.dart';

final themeData = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
  highlightColor: Colors.transparent,
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
    titleTextStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    selectedIconTheme: IconThemeData(size: 0),
    unselectedIconTheme: IconThemeData(size: 0),
  ),
  bottomSheetTheme: const BottomSheetThemeData(modalElevation: 3),
  dialogTheme: const DialogTheme(
    elevation: 3,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: const CardTheme(
    clipBehavior: Clip.hardEdge,
    elevation: 5,
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 10),
    minVerticalPadding: 25,
    horizontalTitleGap: 10,
  ),
  dividerTheme: const DividerThemeData(
    space: 1,
    color: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    extendedPadding: EdgeInsets.all(10),
    extendedTextStyle: TextStyle(fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(10),
      padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 20,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.white),
    )
  ),
);