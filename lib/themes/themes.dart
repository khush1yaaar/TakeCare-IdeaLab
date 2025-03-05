import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = true.obs; // Observable variable

  ThemeMode get themeMode => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeThemeMode(themeMode);
  }
}

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade500,
      scaffoldBackgroundColor: Colors.white,
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
        bodySmall: TextStyle(color: Colors.grey.shade400),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade800,
      scaffoldBackgroundColor: Colors.grey.shade900,
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
