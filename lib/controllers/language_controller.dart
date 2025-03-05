import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString currentLanguage = "English".obs; // Reactive state

  void changeLanguage(String langCode, String countryCode, String languageName) {
    Get.updateLocale(Locale(langCode, countryCode)); // Change app locale
    currentLanguage.value = languageName; // Update state
  }
}
