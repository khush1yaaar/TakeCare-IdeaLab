import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/themes/themes.dart';

class ThemePopup {
  static void show(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeController themeController = Get.find<ThemeController>(); // GetX fix
        final theme = Theme.of(context);

        return AlertDialog(
          title: Text(
            "Select Theme",
            style: TextStyle(color: theme.primaryColor),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Light Theme",
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                leading: const Icon(Icons.wb_sunny, color: Colors.amber),
                onTap: () {
                  if (themeController.isDarkTheme.value) {
                    themeController.toggleTheme(); // Direct toggle, no need for `WidgetsBinding`
                  }
                  Navigator.pop(context); // Close the popup
                },
              ),
              ListTile(
                title: Text(
                  "Dark Theme",
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                leading: const Icon(Icons.nightlight_round, color: Colors.deepPurple),
                onTap: () {
                  if (!themeController.isDarkTheme.value) {
                    themeController.toggleTheme();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
