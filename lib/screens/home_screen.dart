import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:takecare/screens/self_assessment_screen.dart";
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
                children: [
                  HomeCard(
                    title: "Self Assessment".tr,
                    subtitle: "Evaluate your mental well-being".tr,
                    onTap: () {
                      Get.to(SelfAssessmentScreen());
                    },
                  ),
                  HomeCard(
                    title: "Meditation Guide".tr,
                    subtitle: "Relax with guided meditation".tr,
                    onTap: () {
                      
                    },
                  ),
                  HomeCard(
                    title: "Common Mental Health Issues".tr,
                    subtitle: "Learn about anxiety, depression & more".tr,
                    onTap: () {
                      
                    },
                  ),
                  HomeCard(
                    title: "Daily Journal".tr,
                    subtitle: "Track your thoughts and feelings".tr,
                    onTap: () {
                      
                    },
                  ),
                  HomeCard(
                    title: "Stress Management".tr,
                    subtitle: "Tips to reduce stress effectively".tr,
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}