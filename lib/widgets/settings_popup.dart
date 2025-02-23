import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsPopup extends StatefulWidget {
  String title;
  SettingsPopup({super.key, required this.title});

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
