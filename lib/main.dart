import 'package:bot_toast/bot_toast.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/features/login/page/log_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/config/app_theme_manager.dart';
import 'core/config/cash_helper.dart';
import 'core/config/routes.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: AppThemeManager.lightTheme,
      debugShowCheckedModeBanner: false,
        home: const LogView(),
      initialRoute: PageRouteName.login,
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(
builder:BotToastInit()
      ),
    );
  }
}


