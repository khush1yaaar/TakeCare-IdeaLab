import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/widgets/message.dart';
import 'package:takecare/widgets/pet.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final PetController petController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          Message(message: "Hi, I'm Pookie", isUserMessage: true),
          GestureDetector(
            onTap: () {
              petController.flapWings();
            },
            child: Center(child: Pet()),
          ),
        ],
      ),
    );
  }
}
