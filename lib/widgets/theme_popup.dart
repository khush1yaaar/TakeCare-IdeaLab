import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/themes/themes.dart';

class ThemePopup {
  static void show(
    BuildContext context,
    String currentTheme,
    Function(String) onThemeSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeProvider = Provider.of<CustomTheme>(context, listen: false);
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
                  style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                ),
                leading: Icon(Icons.wb_sunny, color: Colors.amber),
                onTap: () {
                  onThemeSelected("Light");
                  if (themeProvider.currentTheme == ThemeMode.dark) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      themeProvider.toggleTheme();
                    });
                  }
                  Navigator.pop(context);
                },
                selected: currentTheme == "Light",
              ),
              ListTile(
                title: Text(
                  "Dark Theme",
                  style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                ),
                leading: Icon(Icons.nightlight_round, color: Colors.deepPurple),
                onTap: () {
                  onThemeSelected("Dark");
                  if (themeProvider.currentTheme == ThemeMode.light) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      themeProvider.toggleTheme();
                    });
                  }
                  Navigator.pop(context);
                },
                selected: currentTheme == "Dark",
              ),
            ],
          ),
        );
      },
    );
  }
}
