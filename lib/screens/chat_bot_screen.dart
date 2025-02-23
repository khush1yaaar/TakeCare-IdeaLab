import 'package:flutter/material.dart';


class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBorScreenState();
}

class _ChatBorScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Chat Bot Screen'),
        ),
      ),
    );
  }
}