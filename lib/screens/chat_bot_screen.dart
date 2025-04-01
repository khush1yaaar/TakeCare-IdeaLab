import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/controllers/pet_controller.dart';
import 'package:takecare/models/message.dart';
import 'package:takecare/widgets/constants.dart';
import 'package:takecare/widgets/message.dart';
import 'package:takecare/widgets/pet.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final PetController _petController = Get.find();
  late String apiKey;
  late GenerativeModel model;
  bool isPetTalking = false;
  bool _isTextFieldFocused = false;
  String previous_conversation = "";

  @override
  void initState() {
    super.initState();
    apiKey = Constants.apikey;
    model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text;
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
      previous_conversation = "user: $previous_conversation $message";
      _userInput.clear();
      isPetTalking = true;
    });

    final content = [
      Content.text(
        "previos Conversaiton: $previous_conversation Users's current message : $message, your prompt : ${Constants.prompt}",
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
      previous_conversation = "You:$previous_conversation ${response.text}";
      isPetTalking = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = bottomInset > 0 ? bottomInset : 20;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 0),
            child: Text(
              'Chat with Zippy!'.tr,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Background decoration
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // ignore: deprecated_member_use
                          theme.primaryColor.withOpacity(0.03),
                          // ignore: deprecated_member_use
                          theme.primaryColor.withOpacity(0.01),
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 160,
                              ), // Increased bottom padding
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
                        ),
                      ),
                    ),

                    // Spacer to push input up and make room for pet
                    SizedBox(height: 100), // This creates space for the pet
                  ],
                ),

                // Input area at the bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 70,
                      top: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  setState(() {
                                    _isTextFieldFocused = hasFocus;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color:
                                          _isTextFieldFocused
                                              ? theme.primaryColor
                                              : Colors.grey[300]!,
                                      width: _isTextFieldFocused ? 1.5 : 1,
                                    ),
                                    boxShadow: [
                                      if (_isTextFieldFocused)
                                        BoxShadow(
                                          // ignore: deprecated_member_use
                                          color: theme.primaryColor.withOpacity(
                                            0.1,
                                          ),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextField(
                                          controller: _userInput,
                                          cursorColor: theme.primaryColor,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                          ),
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Ask your pet anything...',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (value) => sendMessage(),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: theme.primaryColor,
                                          size: 28,
                                        ),
                                        onPressed: sendMessage,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                // Pet positioned absolutely above the input
                Positioned(
                  left: -10,
                  bottom: bottomPadding + 120, // Adjusted position
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
      ),
    );
  }
}
