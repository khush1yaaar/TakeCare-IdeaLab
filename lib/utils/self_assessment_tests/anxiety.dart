import 'package:get/get_utils/get_utils.dart';

class Anxiety {
  List<String> questions = [
    "Feeling nervous, anxious, or on edge?".tr,
    "Not being able to stop or control worrying?".tr,
    "Worrying too much about different things?".tr,
    "Trouble relaxing?".tr,
    "Being so restless that it is hard to sit still?".tr,
    "Becoming easily annoyed or irritable?".tr,
    "Feeling afraid, as if something awful might happen?".tr,
  ];

  List<String> options = [
    "Not at all".tr,
    "Several days".tr,
    "More than half the days".tr,
    "Nearly every day".tr,
  ];

  static Map<String, dynamic> generateReport(List<int> responses) {
    if (responses.length != 7) {
      throw ArgumentError("Invalid number of responses. Expected 7.");
    }

    int totalScore = responses.reduce((a, b) => a + b);

    String severity;
    if (totalScore >= 15) {
      severity = "Severe anxiety: It is recommended to seek professional help immediately.".tr;
    } else if (totalScore >= 10) {
      severity = "Moderate anxiety: Consider consulting a healthcare provider.".tr;
    } else if (totalScore >= 5) {
      severity = "Mild anxiety: Monitoring and self-care strategies might help.".tr;
    } else {
      severity = "Minimal anxiety: Symptoms are not significant, but self-care is still important.".tr;
    }

    return {
      "severity": severity,
      "totalScore": totalScore,
    };
  }
}
