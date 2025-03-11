import 'package:flutter/material.dart';

class PastReportCard extends StatelessWidget {
  final String test;
  final Map<String, dynamic> report;
  PastReportCard({required this.test, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(test, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: report.entries.map((entry) {
        return Text('${entry.key}: ${entry.value}');
          }).toList(),
        ),
      ),
    );
  }
}
