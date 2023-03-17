import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/presentation/common/widgets/loader.dart';
import 'package:whatsapp/presentation/landing/view/landing_screen.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/presentation/user_information/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/screens/mobile_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      onGenerateRoute: GenerateRoute.getRoute,
      home: ref.watch(userInfoProvider).when(
            data: (data) => data == null ? const LandingScreen() : const MobileLayoutScreen(),
            error: (err, trace) => Container(), // TODO: Create Error Screen
            loading: () => const Loader(),
          ),
    );
  }
}
