import 'package:flutter/material.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';
import 'package:whatsapp/presentation/common/widgets/custom_button.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: AppNavigator.appGlobalKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Welcome to Whatsapp",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 9),
            const Image(
              image: AssetImage('assets/images/bg.png'),
              width: 290,
              height: 290,
              color: tabColor,
            ),
            SizedBox(height: size.height / 9),
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 15, end: 15),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of service',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * .75,
              child: CustomButton(
                text: "Agree and continue",
                onPressed: () => Navigator.of(context).pushNamed(Routes.login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
