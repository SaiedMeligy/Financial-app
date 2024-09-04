import 'package:firebase_core/firebase_core.dart';
import 'core/config/routes.dart';
import 'core/config/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'core/config/app_theme_manager.dart';
import 'features/initialPage/page/initial_page.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'firebase_options.dart';



GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'معهد الخبراء العرب للتدريب و الإستشارات',
      theme: AppThemeManager.lightTheme,
      debugShowCheckedModeBanner: false,
        home: const InitialPage(),
      initialRoute: PageRouteName.initial,
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(
        builder:BotToastInit()
      ),
    );
  }
}


