import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class PlayVideoIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double? size;
  const PlayVideoIcon({super.key, required this.icon, required this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        child: Container(
          width: size ?? 50,
          height: size ?? 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.colors.black.withOpacity(.5), borderRadius: BorderRadius.circular(size ?? 50 / 2)),
          child: Icon(
            icon,
            color: AppColors.colors.white,
            size: size != null ? 42 : 25,
          ),
        ),
      ),
    );
  }
}
