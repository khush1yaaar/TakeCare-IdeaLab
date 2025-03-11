import 'package:get/get_utils/get_utils.dart';

class ADHD {
  List<String> questions = [
    "How often do you have trouble wrapping up the final details of a project, once the challenging parts have been done?".tr,
    "How often do you have difficulty getting things in order when you have to do a task that requires organization?".tr,
    "How often do you have problems remembering appointments or obligations?".tr,
    "When you have a task that requires a lot of thought, how often do you avoid or delay getting started?".tr,
    "How often do you fidget or squirm with your hands or feet when you have to sit down for a long time?".tr,
    "How often do you feel overly active and compelled to do things, like you were driven by a motor?".tr,
    "How often do you make careless mistakes when you have to work on a boring or difficult project?".tr,
    "How often do you have difficulty keeping your attention when you are doing boring or repetitive work?".tr,
    "How often do you have difficulty concentrating on what people say to you, even when they are speaking to you directly?".tr,
    "How often do you misplace or have difficulty finding things at home or at work?".tr,
    "How often are you distracted by activity or noise around you?".tr,
    "How often do you leave your seat in meetings or other situations in which you are expected to remain seated?".tr,
    "How often do you feel restless or fidgety?".tr,
    "How often do you have difficulty unwinding and relaxing when you have time to yourself?".tr,
    "How often do you find yourself talking too much when you are in social situations?".tr,
    "When you’re in a conversation, how often do you find yourself finishing the sentences of the people you are talking to, before they can finish them themselves?".tr,
    "How often do you have difficulty waiting your turn in situations when turn taking is required?".tr,
    "How often do you interrupt others when they are busy?".tr,
  ];
  List<String> options = [
    "Never".tr,
    "Rarely".tr,
    "Sometimes".tr,
    "Often".tr,
    "Very Often".tr,
  ];

  static const List<int> partAIndexes = [0, 1, 2, 3, 4, 5]; 
  static const List<int> shadedScores = [3, 4]; 
  static Map<String, dynamic> generateReport(List<int> responses) {
    if (responses.length != 18) {
      throw ArgumentError("Invalid number of responses. Expected 18.");
    }

    int partAScore = 0;
    int partBShadedCount = 0;

    for (int index in partAIndexes) {
      if (shadedScores.contains(responses[index])) {
        partAScore++;
      }
    }

    for (int i = 6; i < 18; i++) {
      if (shadedScores.contains(responses[i])) {
        partBShadedCount++;
      }
    }

    String likelihood;
    if (partAScore >= 4) {
      likelihood = "High likelihood of ADHD: Your responses indicate a strong presence of symptoms associated with ADHD. It is highly recommended that you seek a professional evaluation to explore diagnosis and possible treatment options.".tr;
    } else if (partAScore == 2 || partAScore == 3) {
      likelihood = "Moderate likelihood of ADHD: You have reported some symptoms commonly associated with ADHD. While not definitive, a consultation with a healthcare provider could help assess your condition further.".tr;
    } else {
      likelihood = "Low likelihood of ADHD: Your responses do not strongly align with ADHD symptoms. However, if you still experience challenges in focus, organization, or impulsivity, you may consider discussing them with a professional.".tr;
    }

    String partBAnalysis = "";
    if (partBShadedCount > 6) {
      partBAnalysis = "Your Part B responses indicate additional symptoms that may impact daily functioning. It is advised to discuss these with a professional to assess impairment levels.".tr;
    } else {
      partBAnalysis = "Your Part B responses do not indicate significant additional symptoms, but individual challenges may still exist.".tr;
    }

    return {
      "likelihood": likelihood,
      "partAScore": partAScore,
      "partBAnalysis": partBAnalysis,
      "partBShadedCount": partBShadedCount
    };
  }
}
