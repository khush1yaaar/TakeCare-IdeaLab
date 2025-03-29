import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/widgets/constants.dart';
import 'package:takecare/widgets/message.dart';
import 'package:takecare/widgets/pet.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final PetController _petController = Get.find();
  late String apiKey;
  late GenerativeModel model;
  bool isPetTalking = false; // Controls animation

  @override
  void initState() {
    super.initState();
    apiKey = Constants.apikey;
    model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text;
    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
      _userInput.clear();
      isPetTalking = true; // Pet starts reacting
    });

    final content = [Content.text("$message ${Constants.prompt}")];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(
        Message(
          isUser: false,
          message: response.text ?? "",
          date: DateTime.now(),
        ),
      );
      isPetTalking = false; // Pet stops reacting
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Chat with Your Pet',
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _petController.flapWings();
                  },
                  child: Pet(),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat('HH:mm').format(message.date),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userInput,
                    decoration: InputDecoration(
                      hintText: 'Ask your pet anything...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
