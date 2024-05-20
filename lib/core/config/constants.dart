import 'package:flutter/material.dart';

import '../../main.dart';

class Constants {

  static var theme = Theme.of(navigatorKey.currentState!.context);
  static var mediaQuery = MediaQuery
      .of(navigatorKey.currentState!.context)
      .size;
  static var baseUrl = "http://127.0.0.1:8000";
  static var apiPassword = "FWe4ayY2gaGX8TSM";
  static var myToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE3MTYxNTg5MjEsIm5iZiI6MTcxNjE1ODkyMSwianRpIjoiUXl6Rm9LdkpEcjM2OGZZZiIsInN1YiI6IjQiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Bdxr-6Qj-60TjrXrXD2ZXjHvTkeuNaVnoGEWFsRxswA";
}