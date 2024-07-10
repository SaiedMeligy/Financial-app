import 'core/config/routes.dart';
import 'core/config/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'core/config/app_theme_manager.dart';
import 'features/initialPage/initial_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:experts_app/features/login/page/log_view.dart';



GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  CacheHelper.init();
  runApp(ProviderScope( child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
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


