import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static bool isLoggedInAndNavigate() {
    dynamic rule = sharedPreferences.get('rule');
    dynamic nationalId = sharedPreferences.get('national_id');
    if (rule != null) {
      if (rule == 0) {
        navigatorKey.currentState!
            .pushReplacementNamed(PageRouteName.homeAdvisor);
      } else if (rule == 1) {
        navigatorKey.currentState!
            .pushReplacementNamed(PageRouteName.homeAdmin);
      } else if (rule == 2) {
        navigatorKey.currentState!
            .pushReplacementNamed(PageRouteName.layoutAboZaby);
      }
      return true;
    }else if(nationalId != null){
      return true;
    }
    return false;
  }
  static bool isPationtLoggedIn() {
    dynamic nationalId = sharedPreferences.get('national_id');
    if(nationalId != null){
      return true;
    }
    return false;
  }
  
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await sharedPreferences.clear();
  }
}
