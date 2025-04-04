import 'package:flutter/material.dart';
import 'package:takecare/models/message.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages(
      {
        super.key,
        required this.isUser,
        required this.message,
        required this.date
      });
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100:10,
        right: isUser ? 10: 100
      ),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: isUser ? theme.primaryColor.withOpacity(0.5) : const Color.fromARGB(174, 189, 189, 189),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: isUser ? Radius.circular(10): Radius.zero,
          topRight: Radius.circular(10),
          bottomRight: isUser ? Radius.zero : Radius.circular(10)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 16,color: isUser ? Colors.black: Colors.black),
          ),
          Text(
            date,
            style: TextStyle(fontSize: 10,color: isUser ? Colors.black: Colors.black,),
          )
        ],
      ),
    );
  }
}

class ChatMessages extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}