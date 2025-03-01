import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String currentSetting;
  final VoidCallback? onTap;

  const SettingsCard({
    super.key,
    required this.title,
    required this.currentSetting,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2), // Blend with app bar theme
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: theme.appBarTheme.titleTextStyle?.color ?? Colors.blueAccent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  theme.appBarTheme.backgroundColor ??
                  // ignore: deprecated_member_use
                  Colors.blue.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.appBarTheme.titleTextStyle?.color,
                ),
                overflow: TextOverflow.ellipsis, // Prevents overflow
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentSetting,
                  style: TextStyle(
                    fontSize: 14,
                    // ignore: deprecated_member_use
                    color: theme.appBarTheme.iconTheme?.color?.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: theme.appBarTheme.iconTheme?.color,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
