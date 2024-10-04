import 'package:experts_app/features/aboZaby/layout_abo_zaby.dart';
import 'package:experts_app/features/homeAdvisor/advisor_layout_view.dart';
import 'package:flutter/material.dart';
import '../../features/homeAdmin/home_admin_view.dart';
import '../../features/initialPage/page/initial_page.dart';
import '../../features/login/page/log_view.dart';



class Routes{
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context) => const InitialPage(),settings: settings);
        case '/login':
          return MaterialPageRoute(builder: (context) => const LogView(),settings: settings);
        case '/homeAdmin':
          return MaterialPageRoute(builder: (context) => HomeAdminView(targetIndex: 0,),settings: settings);

          case '/homeAdvisor':
            return MaterialPageRoute(builder: (context) => const AdvisorLayoutView(),settings: settings);

      case '/layoutAboZaby':
        return MaterialPageRoute(builder: (context) => const LayoutAboZabyView(),settings: settings);


            // case '/questionView':
            //   return MaterialPageRoute(builder: (context) =>  ViewQuestion(
            //
            //   ),settings: settings);


      default:
        return MaterialPageRoute(builder: (context) => const InitialPage(),settings: settings);
    }
  }
}