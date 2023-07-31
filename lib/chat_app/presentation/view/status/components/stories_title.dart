import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class StoriesTitle extends StatelessWidget {
  final String storiesTitle;
  const StoriesTitle(this.storiesTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.colors.neutral10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            storiesTitle,
            style: TextStyle(
              color: AppColors.colors.neutral14,
              fontSize: 12,
              fontFamily: 'Neue Helvetica',
              fontWeight: FontWeight.w500,
            ),
          ),
          // Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}