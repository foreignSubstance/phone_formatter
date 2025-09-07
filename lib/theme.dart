import 'package:flutter/material.dart';

final defaultTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: Color(0xff8EAAFB),
  colorScheme: ColorScheme.light(
    primary: Color(0xffF4F5FF).withValues(alpha: 0.4),
    secondary: Color(0xff594C74),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(fixedSize: WidgetStatePropertyAll<Size>(Size(20, 20))),
  ),
  textTheme: ThemeData().textTheme.copyWith(
    titleLarge: const TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: Color(0xff594C74), fontSize: 16),
  ),
);
