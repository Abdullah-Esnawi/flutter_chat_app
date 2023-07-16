import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/camera_screen.dart';
// import 'package:whatsapp/chat_app/presentation/view/camera/camera_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/auth_viewmodel.dart';
import 'package:whatsapp/core/resources/app_navigator.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/contacts_list.dart';
import 'package:whatsapp/generated/l10n.dart';

// final _currentIndex = StateProvider((ref) => 1);

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener((){
            setState(() {
        _currentIndex = _tabController.index;
      });

    });
  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

// Change User's Active state when close or Open The Application
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await ref.watch(authViewmodelProvider).setUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        await ref.watch(authViewmodelProvider).setUserState(false);
        break;
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return DefaultTabController(
      key: AppNavigator.appGlobalKey,
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: AppColors.colors.neutral90,
        appBar: AppBar(
          title: Text(
            strings.whatsapp,
            style: TextStyle(
              fontSize: 20,
              color: AppColors.colors.neutral13,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: AppColors.colors.neutral13),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.colors.neutral13),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.colors.white,
            indicatorPadding: const EdgeInsets.only(bottom: .4),
            indicatorWeight: 4,
            labelColor: AppColors.colors.white,
            unselectedLabelColor: AppColors.colors.white.withOpacity(.6),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            tabs: [
              const Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: strings.chatsTabLabel,
              ),
              Tab(
                text: strings.statusTabLabel,
              ),
              Tab(
                text: strings.callsTabLabel,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            CameraScreen(receiverId: 'Ebk5Kf7v6zWcEopCIWeVVO7giIv1'),
            ContactsList(),
            Center(child: Text('STATUS')),
            Center(child: Text('CALLS')),
          ],
        ), // create provider
        floatingActionButton: _currentIndex != 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.selectContactScreen);
                },
                backgroundColor: AppColors.colors.primary,
                child: Icon(
                  Icons.comment,
                  color: AppColors.colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
