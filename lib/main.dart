import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
import 'package:whatsapp/chat_app/presentation/view/landing/landing_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/cache/app_shared_prefs.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    onAppLaunch();
    super.initState();
  }

  Future<void> onAppLaunch() async {
    final sharedPreference = ref.read(appSharedPreferenceProvider);
    await sharedPreference.init();
    final currentLang = sharedPreference.getCurrentLang();
    if (currentLang != null) {
      ref.read(appCurrentLanguageProvider.notifier).state =
          AppLanguage.values.firstWhere((element) => currentLang == element.value);
    }
  }

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
            data: (data) => data == null ? const LandingScreen() : const MainNavigationScreen(),

            //  ChatScreen(
            //   uid: '9j9jWKetJ4hla6vK4lB1clktrco2',
            //   username: 'Abdullah',
            // ),
            error: (err, trace) => WidgetError(message: err.toString(), tryAgain: () {  },), // TODO: Create Error Screen
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
