import 'package:flutter/material.dart';

abstract class CustomThemes {
  CustomThemes._();

  static lightTheme(context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      fontFamily: 'Montserrat',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      scaffoldBackgroundColor: Colors.blueAccent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
