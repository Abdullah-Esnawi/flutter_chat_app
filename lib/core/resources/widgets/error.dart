import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// TODO: Remove [WidgetError] and create the Correct Widget error
class WidgetError extends StatelessWidget {
  final String message;
  final Function() tryAgain;
  const WidgetError({super.key, required this.message, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          OutlinedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), alignment: Alignment.center),
              onPressed: () {
                tryAgain();
              },
              child: const Text('Try Again', style: TextStyle(color: Colors.white))),
        ],
      ),
    ));
  }
}
