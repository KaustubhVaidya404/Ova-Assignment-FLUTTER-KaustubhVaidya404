import 'package:chatlily/fireservices/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CusDrawer extends StatelessWidget {
  CusDrawer({super.key});

  String? user = FireAuthService().getCurrentUser()!.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.person),
            title: Text(
              user!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 3,
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.logout),
            title: const Text(
              "Sign out",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              FireAuthService fireAuthService = FireAuthService();
              fireAuthService.signOut();
            },
          )
        ],
      ),
    );
  }
}
