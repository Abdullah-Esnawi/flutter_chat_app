import 'package:flutter/material.dart';
import 'package:whatsapp/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/images/splash_icon.png'),
                width: 100,
                height: 100,
              ),
            ),
            const Spacer(),
            Text(
              "from",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
            ),
            const Image(
              image: AssetImage('assets/images/meta_logo.png'),
              width: 80,
              color: logoColor,
            ),
            const SizedBox(height: 35)
          ],
        ),
      ),
    );
  }
}
