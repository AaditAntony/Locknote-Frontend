import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF5E35B1);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    //  Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPurple,
      primary: primaryPurple,
      onPrimary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
    ),

    scaffoldBackgroundColor: Colors.white,

    //  Text Theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    //  TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F2F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(color: Colors.black54),
      prefixIconColor: Colors.black54,
    ),

    //  AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
  );
}
