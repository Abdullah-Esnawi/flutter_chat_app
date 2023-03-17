import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/auth/view/login_screen.dart';
import 'package:whatsapp/presentation/auth/view/otp_screen.dart';
import 'package:whatsapp/presentation/contacts/view/select_contact_screen.dart';
import 'package:whatsapp/presentation/landing/view/landing_screen.dart';
import 'package:whatsapp/presentation/landing/view/splash_screen.dart';
import 'package:whatsapp/presentation/user_information/view/user_info_view.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String landing = "/landing";
  static const String OTPScreen = "/otp-screen";
  static const String userInfoScreen = "/user-information";
  static const String selectContactScreen = "/select-contact";
  static const String mobileChatScreen = "/mobile-chat-screen";
}

class GenerateRoute {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case Routes.mobileChatScreen:
        return MaterialPageRoute(builder: (_) => const MobileChatScreen());
      case Routes.OTPScreen:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OTPScreen(verificationId: verificationId));
      case Routes.userInfoScreen:
        return MaterialPageRoute(builder: (_) => const UserInfoView());
      case Routes.selectContactScreen:
        return MaterialPageRoute(builder: (_) => const SelectContactsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('This page doesn\'t exist')),
      ),
    );
  }
}
