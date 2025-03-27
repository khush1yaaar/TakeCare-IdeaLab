import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:takecare/screens/test_screen.dart";
import "package:takecare/utils/self_assessment_tests/adhd.dart";
import "package:takecare/utils/self_assessment_tests/anxiety.dart";
import "package:takecare/utils/self_assessment_tests/bipolar.dart";
import "package:takecare/utils/self_assessment_tests/depression.dart";
import "package:takecare/utils/self_assessment_tests/eating_disorder.dart";
import "package:takecare/widgets/cards/home_card.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final userName = FirebaseAuth.instance.currentUser?.displayName ?? "User";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20),
            child: Text(
              'Welcome $userName! 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeCard(
                    title: "ADHD Test".tr,
                    subtitle:
                        "Ever feel like your mind is in overdrive? Struggling to focus, organize, or sit still? Take this test to understand if ADHD might be a factor."
                            .tr,
                    onTap: () => Get.to(TestScreen(test: ADHD())),
                  ),
                  HomeCard(
                    title: "Depression Test".tr,
                    subtitle:
                        "Feeling persistently down, empty, or exhausted? If joy feels distant and daily tasks overwhelming, this test can help provide clarity."
                            .tr,
                    onTap: () => Get.to(TestScreen(test: Depression())),
                  ),
                  HomeCard(
                    title: "Anxiety Test".tr,
                    subtitle:
                        "Is worry taking over your life? If restlessness, overthinking, or constant unease feel familiar, this test can offer insights."
                            .tr,
                    onTap: () => Get.to(TestScreen(test: Anxiety())),
                  ),
                  HomeCard(
                    title: "Bipolar Test".tr,
                    subtitle:
                        "Swinging between extreme highs and deep lows? If emotional shifts feel unpredictable, this test can help you understand more."
                            .tr,
                    onTap: () => Get.to(TestScreen(test: Bipolar())),
                  ),
                  HomeCard(
                    title: "Eating Disorder Test".tr,
                    subtitle:
                        "Do thoughts about food, weight, or control dominate your mind? If eating feels more like a battle, this test might help you find clarity."
                            .tr,
                    onTap: () => Get.to(TestScreen(test: EatingDisorder())),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
