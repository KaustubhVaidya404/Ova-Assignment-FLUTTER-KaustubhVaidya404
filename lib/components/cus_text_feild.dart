import 'package:flutter/material.dart';

class CusTextFeild extends StatelessWidget {
  final String hintText;
  final bool obscureTexInpt;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const CusTextFeild(
      {super.key,
      required this.hintText,
      required this.obscureTexInpt,
      required this.controller,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          hintText: hintText,
        ),
        obscureText: obscureTexInpt,
      ),
    );
  }
}
