import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePopup {
  static void show(
    BuildContext context,
    List<Map<String, String>> languages, // List with language details
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: Text(
            "Select Language".tr,
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
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.primaryColor, // Border color
                        width: 1.5, // Border thickness
                      ),
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: const EdgeInsets.all(
                      12,
                    ), // Padding inside the border
                    child: Text(
                      languages[index]['name']!, // Display language name
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                  ),

                  onTap: () {
                    String langCode = languages[index]['code']!;
                    String countryCode = languages[index]['country']!;

                    // Update the app's locale
                    Get.updateLocale(Locale(langCode, countryCode));

                    Navigator.pop(context); // Close the popup
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel".tr,
                style: TextStyle(color: theme.primaryColor),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
