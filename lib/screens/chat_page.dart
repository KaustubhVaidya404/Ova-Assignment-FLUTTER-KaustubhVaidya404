import 'package:chatlily/components/cus_text_feild.dart';
import 'package:chatlily/fireservices/auth/auth_service.dart';
import 'package:chatlily/fireservices/chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final FireAuthService _authService = FireAuthService();

  void sendMessage() {
    _chatService.sendMessage(_messageController.text, receiverId);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(children: [
        Expanded(child: _messageList()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _userInp(),
        ),
      ]),
    );
  }

  Widget _messageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((message) => _messageTile(message))
                .toList(),
          );
        });
  }

  Widget _messageTile(message) {
    Map<String, dynamic> data = message.data() as Map<String, dynamic>;

    return Text(data['message']);
  }

  Widget _userInp() {
    return Row(
      children: [
        Expanded(
            child: CusTextFeild(
                hintText: "Enter message",
                obscureTexInpt: false,
                controller: _messageController)),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ],
    );
  }
}
