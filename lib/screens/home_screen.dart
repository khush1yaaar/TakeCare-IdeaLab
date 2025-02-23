import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:takecare/models/home_screen_tile.dart";
import "package:takecare/widgets/custom_tile.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "User";

    List<HomeScreenTile> homeScreenTiles = [
      HomeScreenTile(
        title: "Self Assessment",
        subtitle: "Evaluate your mental well-being",
        image: "assets/self_assessment.png",
        route: "/selfAssessment",
      ),
      HomeScreenTile(
        title: "Meditation Guide",
        subtitle: "Relax with guided meditation",
        image: "assets/meditation_guide.png",
        route: "/meditationGuide",
      ),
      HomeScreenTile(
        title: "Common Mental Health Issues",
        subtitle: "Learn about anxiety, depression & more",
        image: "assets/mental_health_issues.png",
        route: "/mentalHealthIssues",
      ),
      HomeScreenTile(
        title: "Daily Journal",
        subtitle: "Track your thoughts and feelings",
        image: "assets/daily_journal.png",
        route: "/dailyJournal",
      ),
      HomeScreenTile(
        title: "Stress Management",
        subtitle: "Tips to reduce stress effectively",
        image: "assets/stress_management.png",
        route: "/stressManagement",
      ),
    ];

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
            child: ListView.builder(
              itemCount: homeScreenTiles.length,
              itemBuilder: (context, index) {
                final tile = homeScreenTiles[index];
                return CustomTile(
                  title: tile.title,
                  subtitle: tile.subtitle,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
