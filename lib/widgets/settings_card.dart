import 'package:flutter/material.dart';
import 'package:takecare/providers/auth_provider.dart';
import 'package:takecare/screens/getstarted_screen.dart';
import 'package:takecare/widgets/theme_popup.dart';

// ignore: must_be_immutable
class SettingsCard extends StatefulWidget {
  String title;
  String currentSetting;
  SettingsCard({super.key, required this.title, required this.currentSetting});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _auth = AuthProvider();

    return GestureDetector(
      onTap: () {
        if (widget.title == "Theme") {
          ThemePopup.show(context, widget.currentSetting, (newTheme) {
            setState(() {
              widget.currentSetting = newTheme;
            });
          });
        }
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
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
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Pushes right content to the end
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.appBarTheme.titleTextStyle?.color,
                ),
                overflow: TextOverflow.ellipsis, // Prevents overflow
                maxLines: 1,
              ),
            ),
            SizedBox(width: 16), // Spacing between title and right-side content
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.currentSetting,
                  style: TextStyle(
                    fontSize: 14,
                    // ignore: deprecated_member_use
                    color: theme.appBarTheme.iconTheme?.color?.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 8), // Spacing before arrow
                GestureDetector(
                  onTap: () async {
                    if (widget.title == "logout") {
                      await _auth.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetStartedScreen(),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: theme.appBarTheme.iconTheme?.color,
                    size: 16, // Adjusted icon size
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
