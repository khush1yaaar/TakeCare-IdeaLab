import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/screens/test_screen.dart';
import 'package:takecare/utils/self_assessment_tests/adhd.dart';
import 'package:takecare/widgets/cards/home_card.dart';

class SelfAssessmentScreen extends StatelessWidget {
  const SelfAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20),
            child: Text(
              'Self Assessment Tests',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                HomeCard(
                  title: "ADHD Test".tr,
                  subtitle:
                      "Ever feel like your mind is in overdrive? Struggling to focus, organize, or sit still? Take this test to understand if ADHD might be a factor.".tr,
                  onTap: () => Get.to(TestScreen(test: ADHD())),
                ),
                HomeCard(
                  title: "Depression Test".tr,
                  subtitle:
                      "Feeling persistently down, empty, or exhausted? If joy feels distant and daily tasks overwhelming, this test can help provide clarity.".tr,
                  onTap:
                      () => Get.snackbar(
                        "Depression Test Selected".tr,
                        "Starting your test...".tr,
                      ),
                ),
                HomeCard(
                  title: "Anxiety Test".tr,
                  subtitle:
                      "Is worry taking over your life? If restlessness, overthinking, or constant unease feel familiar, this test can offer insights.".tr,
                  onTap:
                      () => Get.snackbar(
                        "Anxiety Test Selected".tr,
                        "Starting your test...".tr,
                      ),
                ),
                HomeCard(
                  title: "Bipolar Test".tr,
                  subtitle:
                      "Swinging between extreme highs and deep lows? If emotional shifts feel unpredictable, this test can help you understand more.".tr,
                  onTap:
                      () => Get.snackbar(
                        "Bipolar Test Selected".tr,
                        "Starting your test...".tr,
                      ),
                ),
                HomeCard(
                  title: "Eating Disorder Test".tr,
                  subtitle:
                      "Do thoughts about food, weight, or control dominate your mind? If eating feels more like a battle, this test might help you find clarity.".tr,
                  onTap:
                      () => Get.snackbar(
                        "Eating Disorder Test Selected".tr,
                        "Starting your test...".tr,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
