import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/widgets/message.dart';
import 'package:takecare/widgets/pet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final PetController petController = Get.find<PetController>();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, String>> chatMessages = [
    {"role": "system", "content": "Hi, I am pookie"},
  ];

  Future<void> query(String prompt) async {
    setState(() {
      chatMessages.add({"role": "user", "content": prompt});
    });

    final data = {"model": "llama3", "messages": chatMessages, "stream": false};

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.100:11434/api/chat"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Decoded response: $responseData");

        String aiResponse = "";
        if (responseData.containsKey("message") &&
            responseData["message"] is Map &&
            responseData["message"].containsKey("content")) {
          aiResponse = responseData["message"]["content"];
        } else if (responseData.containsKey("content")) {
          aiResponse = responseData["content"];
        }

        if (aiResponse.trim().isEmpty) {
          aiResponse = "I'm here to support you. How are you feeling?";
        }

        setState(() {
          chatMessages.add({"role": "assistant", "content": aiResponse});
        });
      } else {
        print("Server error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Network error: $e");
    }
  }

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
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: chatMessages.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  return Message(
                    message: message["content"]!,
                    isUserMessage: message["role"] == "user",
                  );
                },
              ),
            ),
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
      padding:
          _focusNode.hasFocus
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: 70.0, left: 5, right: 5),
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  print("Sending message: ${_messageController.text.trim()}");
                  query(_messageController.text.trim());
                  petController.nod();
                  _messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
