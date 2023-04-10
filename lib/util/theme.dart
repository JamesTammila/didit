import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
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
  textTheme: const TextTheme(
    //TODO Apply MaxLines and Overflow themes for texts
    bodySmall: TextStyle(fontSize: 10),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
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
    contentPadding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
    minVerticalPadding: 15,
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
      textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
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
  outlinedButtonTheme: OutlinedButtonThemeData(
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