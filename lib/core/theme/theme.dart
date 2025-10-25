import 'package:flutter/material.dart';

class Theme {
  // enum AppThemeMode { light, dark }

  static ThemeData getTheme() {
    return darkTheme;
  }

  static final ThemeData lightTheme = ThemeData(
    // drawerTheme: DrawerThemeData(backgroundColor: Colors.amber),

    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.brown,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.brown,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(
      
      backgroundColor: Color.fromARGB(255, 230, 90, 90)),
  );
}
