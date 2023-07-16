import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colors.primary, minimumSize: const Size(double.infinity, 50)),
      child: Text(text),
    );
  }
}
