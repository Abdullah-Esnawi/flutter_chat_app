import 'package:flutter/material.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/auth/login_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/auth/otp_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/picked_image_view.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/picked_video_view.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/chat_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/landing/privacy_agree_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/landing/splash_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/user_info/select_contact_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/user_info/user_info_view.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String privacy = "/landing";
  static const String pickedImageView = "/file-picked-view";
  static const String pickedVideoView = "/file-picked-view";
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
        final arguments = settings.arguments as Map<String, dynamic>;
        final UserInfoEntity? userData = arguments['userInfo'];
        return MaterialPageRoute(builder: (_) => SplashScreen(userData: userData));
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.privacy:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case Routes.pickedImageView:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String path = arguments['path'];
        return MaterialPageRoute(builder: (_) => PickedImageView(path: path));
              case Routes.pickedVideoView:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String path = arguments['path'];
        return MaterialPageRoute(builder: (_) => PickedVideoView(path: path));
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
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
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
