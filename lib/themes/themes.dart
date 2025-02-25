import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isDarkTheme = true;

  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade500,
      scaffoldBackgroundColor: Colors.white, // Updated

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade50,
        titleTextStyle: TextStyle(color: Colors.blue.shade500),
        iconTheme: IconThemeData(color: Colors.blue.shade500),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.grey.shade800),
        displayMedium: TextStyle(color: Colors.grey.shade800),
        displaySmall: TextStyle(color: Colors.grey.shade800),
        headlineLarge: TextStyle(color: Colors.blue.shade700),
        headlineMedium: TextStyle(color: Colors.blue.shade700),
        headlineSmall: TextStyle(color: Colors.blue.shade700),
        bodyLarge: TextStyle(color: Colors.grey.shade800),
        bodyMedium: TextStyle(color: Colors.grey.shade700),
        bodySmall: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade800,
      scaffoldBackgroundColor: Colors.grey.shade900, // Updated

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        titleTextStyle: TextStyle(color: Colors.blue.shade600),
        iconTheme: IconThemeData(color: Colors.blue.shade600),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.blueGrey.shade200),
        displayMedium: TextStyle(color: Colors.blueGrey.shade200),
        displaySmall: TextStyle(color: Colors.blueGrey.shade200),
        headlineLarge: TextStyle(color: Colors.blue.shade300),
        headlineMedium: TextStyle(color: Colors.blue.shade300),
        headlineSmall: TextStyle(color: Colors.blue.shade300),
        bodyLarge: TextStyle(color: Colors.grey.shade300),
        bodyMedium: TextStyle(color: Colors.grey.shade200),
        bodySmall: TextStyle(color: Colors.grey.shade100),
      ),
    );
  }
}
