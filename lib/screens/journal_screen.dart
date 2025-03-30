import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/screens/journal_writing_screen.dart';
import 'package:takecare/widgets/cards/journal_card.dart';
import 'package:takecare/widgets/pet.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid ?? "User ID";
  final PetController _petController = Get.find();

  Future<List<Map<String, dynamic>>> fetchJournalEntries() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists && userDoc.data() != null) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      if (data.containsKey('journal') && data['journal'] is Map) {
        return (data['journal'] as Map<String, dynamic>).entries.map((entry) {
          return {'date': entry.key, 'content': entry.value};
        }).toList();
      }
    }
    return [];
  }

  void writeJournal() {
    String todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    Get.to(JournalWritingScreen(date: todayDate));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchJournalEntries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                );
              }

              final journalEntries = snapshot.data ?? [];
              bool isJournalEmpty = journalEntries.isEmpty;

              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20),
                    child: Text(
                      'How was your day?'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchJournalEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: theme.primaryColor),
                  );
                }

                final journalEntries = snapshot.data ?? [];
                bool isJournalEmpty = journalEntries.isEmpty;

                if (isJournalEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          bottom:
                              40, // Adjust this to control how much the pet overlaps the button
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.6,
                              child: GestureDetector(
                                onTap: () {
                                  _petController.flapWings();
                                },
                                child: Pet(),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: writeJournal,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: theme.primaryColor,
                          ),
                          child: Text(
                            "Start Writing Your Journal",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Stack(
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: journalEntries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 16, // Horizontal spacing
                        mainAxisSpacing: 16, // Vertical spacing
                        childAspectRatio:
                            0.8, // Adjust height/width ratio as needed
                      ),
                      itemBuilder: (context, index) {
                        return JournalCard(entry: journalEntries[index]);
                      },
                    ),
                    if (!isJournalEmpty) // Only show pet if journal is not empty
                      Positioned(
                        bottom: 60,
                        left: -10,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.5,
                              child: GestureDetector(
                                onTap: () {
                                  _petController.smile();
                                },
                                child: Pet(),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchJournalEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: FloatingActionButton(
              onPressed: writeJournal,
              backgroundColor: theme.primaryColor,
              child: Icon(Icons.edit, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
