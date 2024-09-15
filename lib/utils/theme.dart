import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.teal[800]),
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.teal[700]),
      titleMedium: TextStyle(fontSize: 16.0, color: Colors.teal[600]),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[700],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.teal[50],
      labelStyle: TextStyle(color: Colors.teal[700]),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.teal[100]),
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.teal[200]),
      titleMedium: TextStyle(fontSize: 16.0, color: Colors.teal[300]),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[700],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.teal[800],
      labelStyle: TextStyle(color: Colors.teal[100]),
    ),
  );
}