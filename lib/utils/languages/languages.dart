import 'package:get/get.dart';
import 'package:takecare/utils/languages/french_translations.dart';
import 'package:takecare/utils/languages/hindi_translations.dart';
import 'package:takecare/utils/languages/marathi_translations.dart';
import 'package:takecare/utils/languages/tamil_translations.dart';

class AppTranslations extends Translations {
  String currentLanguage = "English";
  @override
 Map<String, Map<String, String>> get keys => {
        'fr_FR': FrenchTranslations().keys['fr_FR']!,
        'hi_IN' : HindiTranslations().keys['hi_IN']!,
        'mr_IN': MarathiTranslations().keys['mr_IN']!,
        'ta_IN' : TamilTranslations().keys['ta_IN']!,
      };
}
