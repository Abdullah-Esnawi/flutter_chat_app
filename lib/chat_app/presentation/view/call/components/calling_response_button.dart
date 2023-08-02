import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class ResponseOnCallWidget extends StatefulWidget {
  const ResponseOnCallWidget({
    super.key,
    required this.onTap,
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.spaceBetweenWidgets,
    this.isMiddleButton = false,
  });

  final double? spaceBetweenWidgets;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;
  final IconData icon;
  final String label;
  final bool isMiddleButton;

  @override
  State<ResponseOnCallWidget> createState() => _ResponseOnCallWidgetState();
}

class _ResponseOnCallWidgetState extends State<ResponseOnCallWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)
    ..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.3))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.isMiddleButton
              ? SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    alignment: Alignment.center,
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: widget.background),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor,
                      size: 24,
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: widget.background),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 24,
                  ),
                ),
          SizedBox(height: widget.spaceBetweenWidgets ?? 10),
          Text(widget.label, style: TextStyle(fontSize: 14, color: AppColors.colors.neutral14))
        ],
      ),
    );
  }
}
