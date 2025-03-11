import 'package:flutter/material.dart';
import 'package:takecare/widgets/button.dart';

class LogoutPopup extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutPopup({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        'Logout',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.primaryColor),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyle(color: theme.textTheme.bodyLarge!.color),
      ),
      actions: [
        Button(
          text: 'Logout',
          onPressed: onLogout,
          isEnabled: true,
        ),
        Button(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
          isEnabled: true,
        ),
      ],
    );
  }
}
