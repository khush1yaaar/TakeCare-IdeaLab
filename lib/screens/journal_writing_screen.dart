import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class JournalWritingScreen extends StatefulWidget {
  const JournalWritingScreen({super.key});

  @override
  State<JournalWritingScreen> createState() => _JournalWritingScreenState();
}

class _JournalWritingScreenState extends State<JournalWritingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? "User ID";
  final TextEditingController _journalController = TextEditingController();
  late String todayDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _loadJournalEntry();
  }

  Future<void> _loadJournalEntry() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists && userDoc.data() != null) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      if (data.containsKey('journal') &&
          data['journal'] is Map &&
          data['journal'][todayDate] != null) {
        _journalController.text = data['journal'][todayDate];
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> _saveJournalEntry() async {
    await _firestore.collection('users').doc(userId).set({
      'journal': {todayDate: _journalController.text},
    }, SetOptions(merge: true));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20),
                child: Text(
                  'How was your day?',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    _saveJournalEntry();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.check, color: theme.primaryColor),
                ),
              ),
            ],
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _journalController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 18),
                    cursorColor: theme.primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Start writing your thoughts... ',
                    ),
                    autofocus: true,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
