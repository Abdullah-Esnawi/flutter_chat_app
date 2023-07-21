
import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';


class FileTypeItem extends StatelessWidget {
  final String typeName;
  final IconData icon;
  final Color background;
  final VoidCallback onPressed;
  const FileTypeItem(
      {super.key, required this.typeName, required this.icon, required this.background, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50 / 2), color: background),
            child: Center(child: Icon(icon, color: AppColors.colors.white, size: 24)),
          ),
          const SizedBox(height: 6),
          Text(
            typeName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.colors.neutral14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
