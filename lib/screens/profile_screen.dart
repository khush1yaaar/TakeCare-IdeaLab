import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/auth_controller.dart';
import 'package:takecare/themes/themes.dart';
import 'package:takecare/widgets/alert_popups/language_popup.dart';
import 'package:takecare/widgets/alert_popups/theme_popup.dart';
import 'package:takecare/widgets/cards/settings_card.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Obx(() {
        final user = _authController.user.value;
        List<Map<String, String>> languages = [
          {'name': 'English', 'code': 'en', 'country': 'US'},
          {'name': 'Français', 'code': 'fr', 'country': 'FR'},
          {'name': 'हिन्दी', 'code': 'hi', 'country': 'IN'},
        ];

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    user?.photoURL != null
                        ? Image.network(user!.photoURL!, fit: BoxFit.cover)
                        : const Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.white,
                        ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
              ),
              backgroundColor: Colors.blue.shade500,
              elevation: 8,
            ),
            SliverToBoxAdapter(
              child: Container(
                color:
                    themeController.isDarkTheme.value
                        ? Colors.grey.shade900
                        : Colors.white, // Dynamic background color
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? 'User',
                      style: TextStyle(
                        fontSize: 30,
                        color:
                            themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user?.email ?? "email",
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            themeController.isDarkTheme.value
                                ? Colors.white70
                                : Colors.black54,
                      ),
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
                      currentSetting:
                          themeController.isDarkTheme.value ? "Dark" : "Light",
                      onTap: () => ThemePopup.show(context),
                    ),
                    SettingsCard(
                      title: "Language",
                      currentSetting: "English",
                      onTap: () => LanguagePopup.show(context, languages),
                    ),
                    SettingsCard(
                      title: "Past Reports",
                      currentSetting: "View History",
                      onTap: () {},
                    ),
                    SettingsCard(
                      title: "Account Settings",
                      currentSetting: "Manage",
                      onTap: () {},
                    ),
                    SettingsCard(
                      title: "Logout",
                      currentSetting: "",
                      onTap: () => _authController.logout(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
