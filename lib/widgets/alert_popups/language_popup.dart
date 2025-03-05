import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/language_controller.dart';

class LanguagePopup {
  static void show(BuildContext context, List<Map<String, String>> languages) {
    final LanguageController controller = Get.find(); // Get the controller

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text("Select Language".tr, style: TextStyle(color: theme.primaryColor)),
          backgroundColor: theme.scaffoldBackgroundColor,
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      languages[index]['name']!,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                  ),
                  onTap: () {
                    String langCode = languages[index]['code']!;
                    String countryCode = languages[index]['country']!;
                    String languageName = languages[index]['name']!;

                    controller.changeLanguage(langCode, countryCode, languageName); // Update language
                    Navigator.pop(context); // Close dialog
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel".tr, style: TextStyle(color: theme.primaryColor)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
