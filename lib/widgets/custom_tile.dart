import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.2), // Blend with app bar theme
        borderRadius: BorderRadius.circular(15),
        // ignore: deprecated_member_use
        border: Border.all(
          color: theme.appBarTheme.titleTextStyle!.color ?? Colors.blueAccent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: theme.appBarTheme.backgroundColor ?? Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.appBarTheme.titleTextStyle!.color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              // ignore: deprecated_member_use
              color: theme.appBarTheme.iconTheme!.color?.withOpacity(
                0.7,
              ), // Adjusting for soft contrast
            ),
          ),
        ],
      ),
    );
  }
}
