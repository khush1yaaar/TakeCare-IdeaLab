import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
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
                    title: "Self Assessment",
                    subtitle: "Evaluate your mental well-being",
                    
                  ),
                  HomeCard(
                    title: "Meditation Guide",
                    subtitle: "Relax with guided meditation",
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  HomeCard(
                    title: "Common Mental Health Issues",
                    subtitle: "Learn about anxiety, depression & more",
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  HomeCard(
                    title: "Daily Journal",
                    subtitle: "Track your thoughts and feelings",
                    onTap: () {
                      // Handle navigation or action
                    },
                  ),
                  HomeCard(
                    title: "Stress Management",
                    subtitle: "Tips to reduce stress effectively",
                    onTap: () {
                      // Handle navigation or action
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