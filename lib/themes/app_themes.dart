import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(72, 145, 148, 70)),
    splashColor: const Color.fromRGBO(72, 145, 148, 70),
    canvasColor: const Color.fromRGBO(250, 250, 250, 1),
    fontFamily: 'Quicksand',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(72, 145, 148, 70)),
    splashColor: const Color.fromRGBO(72, 145, 148, 70),
    canvasColor: const Color.fromRGBO(17, 17, 17, 100),
    fontFamily: 'Quicksand',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
