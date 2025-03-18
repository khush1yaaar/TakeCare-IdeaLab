import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReportScreen extends StatefulWidget {
  Map<String, String> report;
  ReportScreen({super.key, required this.report});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report')),
      body: const Center(child: Text('Report Screen')),
    );
  }
}
