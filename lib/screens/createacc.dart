import 'package:chatlily/components/cus_button.dart';
import 'package:chatlily/components/cus_text_feild.dart';
import 'package:chatlily/config/color_config.dart';
import 'package:chatlily/screens/login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    void register() {
      // register using firebase
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          const Text(
            "Chat Lily",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 20,
          ),
          //email input
          CusTextFeild(
            controller: _emailController,
            hintText: 'Email',
            obscureTexInpt: false,
          ),
          const SizedBox(
            height: 20,
          ),
          //password input
          CusTextFeild(
            controller: _passwordController,
            hintText: 'Password',
            obscureTexInpt: true,
          ),
          const SizedBox(
            height: 20,
          ),
          //confirm password input
          CusTextFeild(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            obscureTexInpt: true,
          ),
          const SizedBox(
            height: 20,
          ),
          //login button
          CusButton(
            displayText: "Register",
            onPressed: register,
          ),
          const SizedBox(
            height: 20,
          ),
          //register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => LoginPage()));
                },
                child: const Text("Login",
                    style: TextStyle(
                        color: registerButtonColor,
                        fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      )),
    );
  }
}
