import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/presentation/common/widgets/loader.dart';
import 'package:whatsapp/presentation/view/chat/mobile_chat_screen.dart';
import 'package:whatsapp/presentation/viewmodel/user_info_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AppSharedPreferences().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late String currentLang = 'en';
  @override
  void initState() {
    // onAppLaunch();
    super.initState();
  }

  // Future<void> onAppLaunch() async {
  //   currentLang = await ref.watch(appSharedPreferenceProvider).getCurrentLang();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      onGenerateRoute: GenerateRoute.getRoute,
      home: ref.watch(userInfoProvider).when(
            data: (data) => MobileChatScreen(
              uid: '9j9jWKetJ4hla6vK4lB1clktrco2',
              username: 'Abdullah',
            ),
            error: (err, trace) => Container(), // TODO: Create Error Screen
            loading: () => const Loader(),
          ),
      locale: Locale(currentLang),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
