import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';

class AppTheme {
  AppTheme._();

  static Brightness brightness = Brightness.light;

  static final systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: AppColors.colors.transparent,
    statusBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: AppColors.colors.neutral45,
    systemNavigationBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
    statusBarBrightness: brightness,
  );

  // SystemUiOverlayStyle(
  //   statusBarColor: AppColors.colors.transparent,
  //   statusBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
  //   systemNavigationBarColor: AppColors.colors.neutral14,
  //   statusBarBrightness: brightness,
  // );

  static final theme = ThemeData().copyWith(
    // textTheme: AppTextTheme.materialTextTheme,
    scaffoldBackgroundColor: AppColors.colors.neutral90,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.colors.neutral70,
      // color: AppColors.colors.neutral13,
      // titleTextStyle: AppTextTheme.headline6Bold.copyWith(color: AppColors.colors.neutral15),
      systemOverlayStyle: systemUiOverlayStyle,
      iconTheme: IconThemeData(color: AppColors.colors.neutral13),
    ),
    colorScheme: ColorScheme(
      primary: AppColors.colors.primary,
      onPrimary: AppColors.colors.white,
      secondary: AppColors.colors.primary100,
      onSecondary: AppColors.colors.white,
      primaryContainer: AppColors.colors.primary100,
      secondaryContainer: AppColors.colors.primary100,
      surface: AppColors.colors.primary100,
      onSurface: AppColors.colors.white,
      background: AppColors.colors.neutral90,
      onBackground: AppColors.colors.neutral13,
      error: AppColors.colors.danger,
      onError: AppColors.colors.white,
      brightness: brightness,
    ),
    // inputDecorationTheme: TxtInputStyle.inputDecorationTheme,
  );
}
