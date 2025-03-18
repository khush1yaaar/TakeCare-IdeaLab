import 'package:get/get_utils/get_utils.dart';

class EatingDisorder {
  List<String> questions = [
    "Am terrified about being overweight?".tr,
    "Avoid eating when I am hungry?".tr,
    "Find myself preoccupied with food?".tr,
    "Have gone on eating binges where I feel that I may not be able to stop?".tr,
    "Cut my food into small pieces?".tr,
    "Aware of the calorie content of foods that I eat?".tr,
    "Particularly avoid food with a high carbohydrate content?".tr,
    "Feel that others would prefer if I ate more?".tr,
    "Vomit after I have eaten?".tr,
    "Feel extremely guilty after eating?".tr,
    "Am preoccupied with a desire to be thinner?".tr,
    "Think about burning up calories when I exercise?".tr,
    "Other people think that I am too thin?".tr,
    "Am preoccupied with the thought of having fat on my body?".tr,
    "Take longer than others to eat my meals?".tr,
    "Avoid foods with sugar in them?".tr,
    "Eat diet foods?".tr,
    "Feel that food controls my life?".tr,
    "Display self-control around food?".tr,
    "Feel that others pressure me to eat?".tr,
    "Give too much time and thought to food?".tr,
    "Feel uncomfortable after eating sweets?".tr,
    "Engage in dieting behavior?".tr,
    "Like my stomach to be empty?".tr,
    "Have the impulse to vomit after meals?".tr,
    "Enjoy trying new rich foods?".tr,
  ];

  List<String> options = [
    "Always".tr,
    "Usually".tr,
    "Often".tr,
    "Sometimes".tr,
    "Rarely".tr,
    "Never".tr,
  ];

  static Map<String, dynamic> generateReport(List<int> responses) {
    if (responses.length != 26) {
      throw ArgumentError("Invalid number of responses. Expected 26.");
    }

    int totalScore = 0;
    for (int i = 0; i < 26; i++) {
      totalScore += (responses[i] > 2) ? responses[i] - 2 : 0;
    }

    String severity;
    if (totalScore >= 20) {
      severity = "High likelihood of an eating disorder: Professional consultation is strongly recommended.".tr;
    } else {
      severity = "Low likelihood of an eating disorder: No immediate concerns, but self-awareness is important.".tr;
    }

    return {
      "severity": severity,
      "totalScore": totalScore,
    };
  }
}