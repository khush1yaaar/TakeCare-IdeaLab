import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:takecare/controllers/auth_controller.dart';
import 'package:takecare/controllers/language_controller.dart';
import 'package:takecare/controllers/notification_controller.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/screens/getstarted_screen.dart';
import 'package:takecare/screens/bottom_nav_bar.dart';
import 'package:takecare/themes/themes.dart';
import 'package:takecare/utils/languages/languages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationController().initNotification();
  Get.put(LanguageController());
  Get.put(AuthController());
  Get.put(PetController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: themeController.themeMode,
        translations: AppTranslations(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.hasData ? BottomNavBar() : const GetStartedScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
