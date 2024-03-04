import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverId;
  const ChatPage({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverId),
      ),
    );
  }
}
