import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:takecare/screens/home_screen.dart';
import 'package:takecare/widgets/button.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20),
            child: Text(
              'Your Past Reports',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
              future:
                  _firestore
                      .collection('users')
                      .doc(_auth.currentUser?.uid)
                      .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text(
                      'No reports yet',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                Map<String, dynamic>? reports =
                    data['reports'] as Map<String, dynamic>?;

                if (reports == null || reports.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "No Reports yet",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Button(
                          text: "Take tests ?",
                          onPressed: () {
                            Get.to(HomeScreen());
                          },
                        ),
                      ),
                    ],
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
          ),
        ],
      ),
    );
  }
}
