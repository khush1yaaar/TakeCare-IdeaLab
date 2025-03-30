import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/widgets/constants.dart';
import 'package:takecare/widgets/message.dart';
import 'package:takecare/widgets/pet.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final PetController _petController = Get.find();
  late String apiKey;
  late GenerativeModel model;
  bool isPetTalking = false;

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

    final content = [
      Content.text(
        "Users message : $message, your prompt : ${Constants.prompt}",
      ),
    ];
    final response = await model.generateContent(content);

    setState(() {
      _petController.nod();
      _messages.add(
        Message(
          isUser: false,
          message: response.text ?? "",
          date: DateTime.now(),
        ),
      );
      isPetTalking = false;
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
    final bottomPadding =
        MediaQuery.of(context).viewInsets.bottom; // Keyboard height
    final curvedNavBarHeight = 65;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "lib/images/chat_screen_background1.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return Messages(
                                isUser: message.isUser,
                                message: message.message,
                                date: DateFormat(
                                  'HH:mm',
                                ).format(message.date),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 120),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          bottomPadding > 0
                              ? bottomPadding +
                                  10 // Keyboard open: 10px above keyboard
                              : curvedNavBarHeight + 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _userInput,
                            cursorColor: theme.primaryColor,
                            decoration: InputDecoration(
                              hintText: 'Ask your pet anything...',
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: theme.primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: theme.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: theme.primaryColor),
                          onPressed: () {
                            _petController.nod();
                            sendMessage();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 10,
                bottom: 120,
                child: GestureDetector(
                  onTap: () {
                    _petController.flapWings();
                  },
                  child: Pet(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
