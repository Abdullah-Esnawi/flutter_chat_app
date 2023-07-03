import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/// TODO: Remove [WidgetError] and create the Correct Widget error
class WidgetError extends StatelessWidget {
  final String message;
  const WidgetError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message)),
    );
  }
}