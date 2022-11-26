import 'package:flutter/material.dart';
import 'package:personal_expenses/themes/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(72, 145, 148, 70)),
    splashColor: const Color.fromRGBO(72, 145, 148, 70),
    canvasColor: const Color.fromRGBO(250, 250, 250, 1),
    fontFamily: 'Quicksand',
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.appBarIconColorLight),
      backgroundColor: AppColors.appBarFillColor,
      titleTextStyle: const TextStyle(
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
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.appBarIconColorDark),
      backgroundColor: AppColors.appBarFillColor,
      titleTextStyle: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
