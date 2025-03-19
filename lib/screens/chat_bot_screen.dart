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
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 50,
            child: GestureDetector(
              onTap: () {
                petController.smile();
                petController.flapWings();
              },
              child: Pet(),
            ),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: Message(message: "Hi, I'm Pookie", isUserMessage: false),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildMessageInputField(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Padding(
      padding: _focusNode.hasFocus ? EdgeInsets.zero : const EdgeInsets.only(bottom: 70.0, left: 5, right: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "Type your message...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Handle message sending logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
