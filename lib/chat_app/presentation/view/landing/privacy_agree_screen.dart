import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/custom_button.dart';
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
            Text(
              "Welcome to Whatsapp",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w600,
                color:
                    Theme.of(context).brightness == Brightness.dark ? AppColors.colors.white : AppColors.colors.primary,
              ),
            ),
            SizedBox(height: size.height / 9),
            AppAssetImage(AppImages.landingScreenBackground,
                width: size.width * .6, height: size.width * .6, color: AppColors.colors.primary),
            SizedBox(height: size.height / 9),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of service',
                style: TextStyle(color: AppColors.colors.neutral14),
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
