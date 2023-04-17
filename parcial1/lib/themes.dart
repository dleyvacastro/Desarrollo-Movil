import 'package:flutter/material.dart';

final ThemeData gameTheme = ThemeData(
  primaryColor: const Color(0xFF41644A),
  scaffoldBackgroundColor: const Color(0xFFF2E3DB),
  fontFamily: 'Anton',
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF41644A),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.black54,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF41644A),
      onPrimary: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    background: Color(0xFF263A29),
    brightness: Brightness.light,
    error: Color(0xFFB00020),
    onBackground: Color(0xFF000000),
    onError: Color(0xFF000000),
    onPrimary: Color(0xFF41644A),
    onSecondary: Color(0xFFE86A33),
    onSurface: Color(0xFF000000),
    primary: Color(0xFF41644A),
    secondary: Color(0xFF41644A),
    surface: Color(0xFF41644A),
  ).copyWith(secondary: const Color(0xFFE86A33)),
);
