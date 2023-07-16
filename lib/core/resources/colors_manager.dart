import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsapp/core/resources/app_theme.dart';

// class mycolors {
//   const mycolors();

//   static const backgroundColor = Color.fromRGBO(19, 28, 33, 1);
//   static const textColor = Color.fromRGBO(241, 241, 242, 1);
//   static const appBarColor = Color.fromRGBO(31, 44, 52, 1);
//   static const webAppBarColor = Color.fromRGBO(42, 47, 50, 1);
//   static const messageColor = Color();
//   static const senderMessageColor = Color();
//   static const tabColor = Color(0xFF02B890);
//   static const logoColor = Color(0xFF00DAAA);
//   static const searchBarColor = Color.fromRGBO(50, 55, 57, 1);
//   static const dividerColor = Color.fromRGBO(37, 45, 50, 1);
//   static const chatBarMessage = Color.fromRGBO(30, 36, 40, 1);
//   static const mobileChatBoxColor = Color.fromRGBO(31, 44, 52, 1);
//   static const greyColor = Colors.grey;
//   static const black = Colors.black;
//   static const primaryColor = Color(0xFF128C7E);
// }

class AppColors {
  const AppColors._();

  static final _light = LightColorScheme();
  static final _dark = DarkColorScheme();

  static AppColorScheme get colors {
    switch (AppTheme.brightness) {
      case Brightness.light:
        return _light;
      case Brightness.dark:
        return _dark;
    }
  }
}

abstract class AppColorScheme {
  AppColorScheme();

  /// ************ common colors
  Color white = const Color(0xffffffff);

  Color primary = const Color(0xff02AD9B);

  Color primary100 = const Color(0xff0CA996);

  Color black = const Color(0xff000000);

  Color black15 = const Color(0xff262626);

  Color black50a = const Color(0x80000000);

  Color transparent = const Color(0x00000000);

  Color danger = const Color(0xFFFF0000);

  /// ************ different colors

  Color get neutral11;

  Color get neutral70;

  Color get neutral90;

  Color get neutral50;

  Color get neutral95;

  Color get neutral75;

  Color get neutral55;

  Color get neutral35;

  Color get neutral15;

  Color get neutral12;

  Color get neutral17;

  Color get neutral14;

  Color get neutral13;

  Color get neutral45;
}

class DarkColorScheme extends AppColorScheme {
  DarkColorScheme();

  @override
  Color get primary => const Color(0xFF128C7E); // Primary color

  @override
  Color get neutral11 => const Color(0xffD3DAE0); // Username color in chats contact list

  @override
  Color get neutral70 => const Color(0xff232D36); // AppBar Background && chat Text filed background

  @override
  Color get neutral90 => const Color(0xff101D25); // Scaffold Background in all App

  @override
  Color get neutral50 => const Color(0xffC5CED3); // Titles color in Settings screen

  @override
  Color get neutral95 => const Color(0xff8A9295); // subtitles color in Settings screen

  @override
  Color get neutral75 => const Color(0xFF056062); //  my message background

  @override
  Color get neutral55 => const Color(0xff80B3AE); // message time sent text color

  @override
  Color get neutral35 => const Color(0xff1E2A31); // chat secure message background

  @override
  Color get neutral15 => const Color(0xffC7BE8A); // chat secure message text color

  @override
  Color get neutral12 => const Color(0xff979DA0); // icons color in Settings screen

  @override
  Color get neutral14 => const Color(0xff889397); // Date color && last message color, icons color, grey color

  @override
  Color get neutral17 => const Color(0xff18252D); // divider color between chat contacts

  @override
  Color get neutral13 => const Color(0xff9DA5AC); // AppBar text and icons color && icons in text field

  @override
  Color get neutral45 => const Color(0xFF252D31); // sender message background
}

class LightColorScheme extends AppColorScheme {
  LightColorScheme();

  @override
  Color get neutral11 => black; // Username color in chats contact list

  @override
  Color get neutral70 => primary; // AppBar Background  // updated

  @override
  Color get neutral90 => white; // Scaffold Background in all App // updated

  @override
  Color get neutral50 => black; // Titles color in Settings screen (Account, Chat, Privacy,UserName etc..) // updated

  @override
  Color get neutral95 => black; // subtitles color in Settings screen // updated

  @override
  Color get neutral75 => const Color(0xFFDCF8C7); //  my message background // updated

  @override
  Color get neutral55 => black.withAlpha(255 ~/ 2); // time sent text color // updated

  @override
  Color get neutral35 => const Color(0xffFFF3BF); // chat secure message background // updated

  @override
  Color get neutral15 => black; // chat secure message text color // updated

  @override
  Color get neutral12 => primary; // icons color in Settings screen // updated

  @override
  Color get neutral14 => const Color(0xff889397); // Date color && last message color // updated but not sure, grey

  @override
  Color get neutral13 => white; // AppBar text and icons color && icons in text field // updated

  @override
  Color get neutral45 => white; // sender message background // updated

  @override
  Color get neutral17 => black.withAlpha(255 ~/ 2); // divider color between chat contacts
}
