import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: tabColor, minimumSize: const Size(double.infinity, 50)),
      child: Text(text),
    );
  }
}
