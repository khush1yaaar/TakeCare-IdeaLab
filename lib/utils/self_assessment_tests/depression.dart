import 'package:get/get_utils/get_utils.dart';

class Depression {
  String name = "depression";
  List<String> questions = [
    "Little interest or pleasure in doing things?".tr,
    "Feeling down, depressed, or hopeless?".tr,
    "Trouble falling or staying asleep, or sleeping too much?".tr,
    "Feeling tired or having little energy?".tr,
    "Poor appetite or overeating?".tr,
    "Feeling bad about yourself or that you are a failure?".tr,
    "Trouble concentrating on things, such as reading or watching TV?".tr,
    "Moving or speaking so slowly that others have noticed? Or being fidgety and restless?"
        .tr,
    "Thoughts that you would be better off dead or hurting yourself?".tr,
  ];

  List<String> options = [
    "Not at all".tr,
    "Several days".tr,
    "More than half the days".tr,
    "Nearly every day".tr,
  ];

  static const List<int> shadedIndexes = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  Map<String, dynamic> generateReport(List<int> responses) {
    if (responses.length != 9) {
      throw ArgumentError("Invalid number of responses. Expected 9.");
    }

    int totalScore = responses.reduce((a, b) => a + b);

    String severity;
    if (totalScore >= 20) {
      severity =
          "Severe depression: It is recommended to seek professional help immediately."
              .tr;
    } else if (totalScore >= 15) {
      severity =
          "Moderately severe depression: Consider consulting a healthcare provider."
              .tr;
    } else if (totalScore >= 10) {
      severity =
          "Moderate depression: Seeking professional advice may be beneficial."
              .tr;
    } else if (totalScore >= 5) {
      severity =
          "Mild depression: Monitoring and self-care strategies might help.".tr;
    } else {
      severity =
          "Minimal depression: Symptoms are not significant, but self-care is still important."
              .tr;
    }

    return {"severity": severity, "totalScore": totalScore};
  }
}
