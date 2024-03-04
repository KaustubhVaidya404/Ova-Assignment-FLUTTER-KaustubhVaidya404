import 'package:chatlily/fireservices/auth/auth_service.dart';
import 'package:flutter/material.dart';

class CusDrawer extends StatelessWidget {
  const CusDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
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
