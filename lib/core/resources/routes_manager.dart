import 'package:flutter/material.dart';
import 'package:whatsapp/chat_app/presentation/view/auth/login_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/auth/otp_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/mobile_chat_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/mobile_main_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/landing/landing_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/landing/splash_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/user_info/select_contact_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/user_info/user_info_view.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String landing = "/landing";
  static const String OTPScreen = "/otp-screen";
  static const String userInfoScreen = "/user-information";
  static const String selectContactScreen = "/select-contact";
  static const String ChatScreen = "/mobile-chat-screen";
  static const String navigationMainScreen = '/navigation-main-screen';
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
      case Routes.ChatScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String name = arguments['name'];
        final String uid = arguments['uid'];
        return MaterialPageRoute(builder: (_) => ChatScreen(username: name, uid: uid));
      case Routes.OTPScreen:
        return MaterialPageRoute(builder: (_) => const OTPScreen());
      case Routes.userInfoScreen:
        return MaterialPageRoute(builder: (_) => const UserInfoView());
      case Routes.navigationMainScreen:
        return MaterialPageRoute(builder: (_) => const MobileLayoutScreen());
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
