import 'package:chatlily/screens/createacc.dart';
import 'package:chatlily/screens/login.dart';
import 'package:flutter/material.dart';

class AccountState extends StatefulWidget {
  const AccountState({super.key});

  @override
  State<AccountState> createState() => _AccountStateState();
}

class _AccountStateState extends State<AccountState> {
  @override
  Widget build(BuildContext context) {
    bool showLogin = true;

    void toggleView() {
      setState(() {
        showLogin = !showLogin;
      });
    }

    if (showLogin) {
      toggleView();
      return LoginPage();
    } else {
      toggleView();
      return RegisterPage();
    }
  }
}
