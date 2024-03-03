import 'package:flutter/material.dart';

class CusButton extends StatelessWidget {
  final String displayText;
  final void Function()? onPressed;
  const CusButton(
      {super.key, required this.displayText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: onPressed,
      child: Text(displayText),
    );
  }
}
