import 'package:flutter/material.dart';

class LanguagePopup {
  static void show(
    BuildContext context,
    List<String> languages,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: Text(
            "Select Language",
            style: TextStyle(color: theme.primaryColor),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    languages[index],
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                  onTap: () {
                    onSelected(languages[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: theme.primaryColor)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
