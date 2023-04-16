import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  primaryColor: Color(0xFFFDB813),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF80AAB8)),
);
