import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/screens/journal_writing_screen.dart';

class JournalCard extends StatelessWidget {
  final Map<String, dynamic> entry;
  const JournalCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              Get.to(JournalWritingScreen(date: entry['date']));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: theme.primaryColor, width: 3.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: theme.textTheme.displayLarge!.color,
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry['date'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        width: double.infinity, // Ensure it expands properly
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            entry['content'],
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: theme.textTheme.displayLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
