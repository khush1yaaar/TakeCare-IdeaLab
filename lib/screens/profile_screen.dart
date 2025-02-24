import 'package:flutter/material.dart';
import 'package:takecare/providers/auth_provider.dart';
import 'package:takecare/themes/themes.dart';
import 'package:takecare/widgets/settings_card.dart';

class ProfileScreen extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = _authProvider.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: user?.photoURL != null
                  ? Image.network(user!.photoURL!, fit: BoxFit.cover)
                  : const Icon(Icons.account_circle, size: 100),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
            ),
            backgroundColor: Colors.blue.shade500,
            elevation: 8,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: theme.primaryColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user?.email ?? "email",
                    style: const TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SettingsCard(
                    title: "Theme",
                    currentSetting: CustomTheme.isDarkTheme ? "Dark" : "Light",
                  ),
                  SettingsCard(
                    title: "Language",
                    currentSetting: "English",
                  ),
                  SettingsCard(
                    title: "Past Reports",
                    currentSetting: "View History",
                  ),
                  SettingsCard(
                    title: "Account Settings",
                    currentSetting: "Manage",
                  ),
                  SettingsCard(
                    title: "logout",
                    currentSetting: "",
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
