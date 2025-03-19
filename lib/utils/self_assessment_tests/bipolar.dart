import 'package:get/get_utils/get_utils.dart';

class Bipolar {
  String name = "Bipolar Disorder";
  List<String> questions = [
    "Elevated Mood?".tr,
    "Increased Motor Activity-Energy?".tr,
    "Sexual Interest?".tr,
    "Sleep disturbance?".tr,
    "Irritability?".tr,
    "Speech (Rate and Amount)?".tr,
    "Language-Thought Disorder?".tr,
    "Content (Delusions, Grandiosity, etc.)?".tr,
    "Disruptive-Aggressive Behavior?".tr,
    "Appearance (Grooming and Dress)?".tr,
    "Insight (Awareness of condition)?".tr,
  ];

  List<String> options = [
    "Absent".tr,
    "Mild".tr,
    "Moderate".tr,
    "Severe".tr,
    "Extreme".tr,
  ];

  Map<String, dynamic> generateReport(List<int> responses) {
    if (responses.length != 11) {
      throw ArgumentError("Invalid number of responses. Expected 11.");
    }

    int totalScore = responses.reduce((a, b) => a + b);

    String severity;
    if (totalScore >= 26) {
      severity =
          "Severe mania: Immediate professional evaluation is recommended.".tr;
    } else if (totalScore >= 20) {
      severity =
          "Moderate mania: Consultation with a healthcare provider is advised."
              .tr;
    } else if (totalScore >= 12) {
      severity =
          "Mild mania: Monitoring and lifestyle adjustments might help.".tr;
    } else {
      severity =
          "Minimal symptoms: No significant manic indications, but self-care is beneficial."
              .tr;
    }

    return {"severity": severity, "totalScore": totalScore};
  }
}
