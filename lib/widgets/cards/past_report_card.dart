import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/screens/report_screen.dart';

// ignore: must_be_immutable
class PastReportCard extends StatelessWidget {
  final String test;
  Map<String, dynamic> report;

  PastReportCard({super.key, required this.report, required this.test});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Get.to(ReportScreen(report: report, name: test));
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                test.tr,
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
                  "Check Report".tr,
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
