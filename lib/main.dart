import 'package:chatlily/auth/user_account_state.dart';
import 'package:chatlily/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AccountState(),
      theme: lightTheme,
    );
  }
}
