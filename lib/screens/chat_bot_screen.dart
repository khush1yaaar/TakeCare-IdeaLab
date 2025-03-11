import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/widgets/pet.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final PetController penguinController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 200, 
            left: MediaQuery.of(context).size.width / 2 - 50, // Centering
            child: GestureDetector(
              onTap: () => penguinController.nod(),
              child: Pet(),
            ),
          ),
        ],
      ),
    );
  }
}
