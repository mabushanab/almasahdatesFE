import 'package:flutter/material.dart';

class myTheme {
  // enum AppThemeMode { light, dark }

  static ThemeData getTheme() {
    return darkTheme;
  }

  static final ThemeData lightTheme = ThemeData(
    // drawerTheme: DrawerThemeData(backgroundColor: Colors.amber),

    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed:  const Color.fromARGB(255, 70, 63, 45),
    scaffoldBackgroundColor: Colors. grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFEED5B7),
      foregroundColor: Color.fromARGB(255, 0, 0, 0),
      centerTitle: true,
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
      
      // backgroundColor: Color.fromARGB(255, 230, 90, 90)
      ),
  );
}
