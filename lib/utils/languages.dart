import 'package:get/get.dart';
import 'package:takecare/utils/french_translations.dart';
import 'package:takecare/utils/hindi_translations.dart';

class AppTranslations extends Translations {
  @override
 Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Self Assessment': 'Self Assessment',
          'Evaluate your mental well-being': 'Evaluate your mental well-being',
          'Meditation Guide': 'Meditation Guide',
          'Relax with guided meditation': 'Relax with guided meditation',
          'Common Mental Health Issues': 'Common Mental Health Issues',
          'Learn about anxiety, depression & more': 'Learn about anxiety, depression & more',
          'Daily Journal': 'Daily Journal',
          'Track your thoughts and feelings': 'Track your thoughts and feelings',
          'Stress Management': 'Stress Management',
          'Tips to reduce stress effectively': 'Tips to reduce stress effectively',
        },

        'fr_FR': FrenchTranslations().keys['fr_FR']!,
        'hi_IN' : HindiTranslations().keys['hi_IN']!
      };
}
