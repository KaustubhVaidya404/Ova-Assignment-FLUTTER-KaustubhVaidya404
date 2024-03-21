import 'package:chatlily/components/user_tile.dart';
import 'package:chatlily/fireservices/auth/auth_service.dart';
import 'package:chatlily/components/cus_drawer.dart';
import 'package:chatlily/fireservices/chats/chats.dart';
import 'package:chatlily/screens/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  FireAuthService fireAuthService = FireAuthService();
  ChatService chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Text(
          'ChatLily',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 35),
        ),
      ),
      drawer: CusDrawer(),
      body: StreamBuilder(
          stream: chatService.getUser(),
          builder: (context, snapshots) {
            if (snapshots.hasError) {
              const Text('Error');
            }
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshots.data!
                  .map<Widget>((userData) => _userList(userData, context))
                  .toList(),
            );
          }),
    );
  }

  Widget _userList(Map<String, dynamic> user, BuildContext context) {
    print(
        "======================================${user}====================================");
    if (user['email'] != fireAuthService.getCurrentUser()!.email) {
      List<dynamic> array = user['connections'];
      if (array.contains(fireAuthService.getCurrentUser()!.uid)) {
        return UserTile(
          text: user['email'],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiverEmail: user['email'],
                          receiverId: user['uid'],
                        )));
          },
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}
