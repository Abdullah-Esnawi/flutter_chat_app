import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/generated/l10n.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key, required this.userData});
  final UserInfoEntity? userData;
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;

  void _startDelay() async {
    _timer = Timer(const Duration(seconds: 1), () {
      if (widget.userData == null) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.privacy, (_) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Routes.navigationMainScreen, (_) => false);
      }
    });
  }

  void _goNext() {
    print('_goNext Function called');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _startDelay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: AppColors.colors.white,
    //     statusBarIconBrightness: Brightness.dark,
    //     navi
    //   ),
    // );
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .19),
            const AppAssetImage(AppImages.splashIcon, width: 250, height: 250),
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${strings.from}\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, color: AppColors.colors.neutral14),
                  ),
                  const WidgetSpan(child: SizedBox(height: 40)),
                  TextSpan(
                    text: "Abdullah Esnawi",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.colors.primary100,
                        fontSize: 24,
                        letterSpacing: .4,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
