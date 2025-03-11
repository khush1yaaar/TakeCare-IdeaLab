import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takecare/widgets/cards/past_report_card.dart';

class PastReportsScreen extends StatefulWidget {
  const PastReportsScreen({super.key});

  @override
  State<PastReportsScreen> createState() => _PastReportsScreenState();
}

class _PastReportsScreenState extends State<PastReportsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Past Reports')),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            _firestore.collection('users').doc(_auth.currentUser?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No reports yet', style: TextStyle(fontSize: 18)),
            );
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Map<String, dynamic>? reports =
              data['reports'] as Map<String, dynamic>?;

          if (reports == null || reports.isEmpty) {
            return const Center(
              child: Text('No reports yet', style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              String test = reports.keys.elementAt(index);
              Map<String, dynamic> report = reports[test];
              return PastReportCard(test: test, report: report);
            },
          );
        },
      ),
    );
  }
}
