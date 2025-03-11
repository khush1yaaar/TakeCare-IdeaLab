import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/chat_bot_screen.dart';
import 'package:takecare/screens/home_screen.dart';
import 'package:takecare/screens/journal_screen.dart';
import 'package:takecare/screens/profile_screen.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homeScreen;
  late JournalScreen journalScreen;
  late ChatBotScreen chatBotScreen;
  late ProfileScreen profileScreen;

  @override
  void initState() {
    homeScreen = HomeScreen();
    journalScreen = const JournalScreen();
    chatBotScreen = const ChatBotScreen();
    profileScreen = ProfileScreen();

    pages = [homeScreen, chatBotScreen, journalScreen, profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context); 

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        color: theme.primaryColor,
        animationDuration: Durations.medium2,
        onTap: (index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.article_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
