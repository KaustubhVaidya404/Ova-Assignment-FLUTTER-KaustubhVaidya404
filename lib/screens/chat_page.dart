import 'package:chatlily/components/chat_bubble.dart';
import 'package:chatlily/components/cus_text_feild.dart';
import 'package:chatlily/fireservices/auth/auth_service.dart';
import 'package:chatlily/fireservices/chats/chat_service.dart';
import 'package:chatlily/fireservices/chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  String? response;

  final ChatService _chatService = ChatService();
  final AiService _aiService = AiService();

  final FireAuthService _authService = FireAuthService();

  FocusNode focusNode = FocusNode();

  void scrollDownMessage() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
            const Duration(milliseconds: 1), () => scrollDownMessage());
      }
    });
    Future.delayed(const Duration(milliseconds: 1), () => scrollDownMessage());
  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();

    super.dispose();
  }

  void sendMessage(String aiResponse) {
    if (aiResponse.isNotEmpty) {
      _chatService.sendMessage(aiResponse, widget.receiverId);
    } else if (_messageController.text.isNotEmpty) {
      _chatService.sendMessage(_messageController.text, widget.receiverId);
    }
    _messageController.clear();
  }

  void aiAssist() async {
    if (_messageController.text.isNotEmpty) {
      response = await _aiService.promptRequest(_messageController.text);
      sendMessage(response!);
      // _messageController.text = response!;
      print(response);
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(widget.receiverEmail),
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
        stream: _chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map<Widget>((message) => _messageTile(message))
                .toList(),
          );
        });
  }

  Widget _messageTile(message) {
    Map<String, dynamic> data = message.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child:
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser));
  }

  Widget _userInp() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
              child: CusTextFeild(
            hintText: "Enter message",
            obscureTexInpt: false,
            controller: _messageController,
            focusNode: focusNode,
          )),
          Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: IconButton(
                  onPressed: aiAssist, icon: const Icon(Icons.rocket))),
          Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    sendMessage;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text("Lily is here to help"),
                                content: Text(response ?? ""),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"))
                                ]));
                  },
                  icon: const Icon(Icons.send)))
        ],
      ),
    );
  }
}
