import 'package:flutter/material.dart';

import '../../main.dart';

class Constants {

  static var theme = Theme.of(navigatorKey.currentState!.context);
  static var mediaQuery = MediaQuery.of(navigatorKey.currentState!.context)
      .size;
   static var baseUrl = "https://financialclinic.site/financial_clinic_apis/public";
   //static var baseUrl = "http://127.0.0.1:8000";
  static var apiPassword = "FWe4ayY2gaGX8TSM";
}