// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';

class WebServices {

  static WebServices? _this;

  factory WebServices() {
    _this ??= WebServices._();
    return _this!;
  }

  Dio freeDio = Dio();
  Dio tokenDio = Dio();

  String lang = "en";

  // DeviceInformation deviceInformation = DeviceInformation();
  // final String storageKeyMobileToken = "Authorization";

  String? mytoken;
  String mobile = "";
  final String storageKeyMobileToken = "Authorization";

  WebServices._() {
    freeDio.options.connectTimeout = const Duration(milliseconds: 30000);
    freeDio.options.baseUrl = Constants.baseUrl;

    tokenDio.options.connectTimeout = const Duration(milliseconds: 30000);
    tokenDio.options.baseUrl = Constants.baseUrl;
    initializeInterceptors();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Initialize language

  /*void _initializeLanguage() async {
    final SharedPreferences prefs = await _prefs;
    lang = prefs.getString("lang") ?? "EN";
  }*/

  /// function to change app language,

  /*void changeLanguage(String language) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("lang", language);
    lang = language;
  }*/

  /// Get current language,

  /*Future<String> getCurrentLang() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('lang') ?? lang;
  }*/

  /// Method that saves the token in Shared Preferences
  Future<bool> setMobileToken(String? token) async {
    mytoken = token;
    final SharedPreferences prefs = await _prefs;
    if (token == null) {
      prefs.remove(storageKeyMobileToken);
      return Future<bool>.value(false);
    } else {
      return prefs.setString(storageKeyMobileToken, token);
    }
  }

  /// Method that returns the token from Shared Preferences

  /*Future<String?> getMobileToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(storageKeyMobileToken) ?? null;
  }*/

  /// initialize tokens

  /*Future<void> initializeToken() async {
    _initializeLanguage();
    mytoken = await getMobileToken();
    // mytoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiIzMyIsImFjY291bnROdW1iZXIiOiIxMTMzNTU3NyIsInVzZXJEaWFsIjoiMTEzMzU1NzciLCJzdWIiOiIxMTMzNTU3NyIsImV4cCI6MTY2OTA5MDE5N30.N--hoT0RPzU2vLs_mJ9tfI8UchLavX_KrBW2iIuj4Mc';
    return;
  }*/

  /// Method that saves the token in Shared Preferences
  //
  // Future<bool> setMobileToken(String? token) async {
  //   mytoken = token;
  //   final SharedPreferences prefs = await _prefs;
  //   if (token == null) {
  //     prefs.remove("Authorization");
  //     return Future<bool>.value(false);
  //   } else {
  //     return prefs.setString("Authorization", token);
  //   }
  // }

  Future<String?> getMobileToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("Authorization");
  }

  /// ----------------------------------------------------------
  /// initialize tokens

  Future<void> initializeToken() async {
    mytoken = await getMobileToken();
    return;
  }

  initializeInterceptors() {


    // Clearing Interceptors
    freeDio.interceptors.clear();
    tokenDio.interceptors.clear();

    // freeDio Interceptors
    freeDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["lang"] = "en";
          options.headers["appVersion"] = "1.1.0";
          options.headers["platform"] = "ios";
          // options.headers["Accept-Language"] =
          //     navigatorKey.currentContext!.locale;

          debugPrint(
              'send request：baseURL:${options.baseUrl} path:${options.path}，');
          debugPrint('headers: ${options.headers}');
          debugPrint('query parameters: ${options.queryParameters}');
          debugPrint('data: ${options.data}');

          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse: (response, handler) {
          debugPrint("status code: ${response.statusCode}");
          debugPrint("status code: ${response.requestOptions.path}");
          debugPrint("data: ${response.data}");

          // Do something with response data
          log(response.data.toString());
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          debugPrint('statusCode: ${e.response?.statusCode}');
          debugPrint('path: ${e.requestOptions.path}');
          debugPrint('response: ${e.response}');
          debugPrint('data: ${e.response?.data}');
          debugPrint("error ${e.error}");
          debugPrint("message ${e.message}");
          debugPrint("type ${e.type}");

          /// Todo Handeling EasyLoading
          EasyLoading.dismiss();

          if (e.response != null) {
            if (e.response!.statusCode == 401 ||
                e.response!.statusCode == 403) {
              return handler.next(e);
            } else {
              // 500 error internal
              // ToastService.showUnExpectedErrorToast();
            }
          } else {
            debugPrint(e.requestOptions.path);
            debugPrint(e.toString());

            // ToastService.showErrorToast("No Internet Connection");
          }
        },
      ),
    );

    tokenDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.path != "digitalapi/profile/digitalBE/token/resetData")
            // EasyLoading.show();
            // Do something before request is sent
            options.headers["Accept-Language"] =
            // navigatorKey.currentContext!.locale;
            options.headers["Authorization"] = "Bearer $mytoken";

          debugPrint(
              'send request path:${options.path}，baseURL:${options.baseUrl}');
          debugPrint("method: ${options.method}");
          debugPrint('headers: ${options.headers}');
          debugPrint('data: ${options.data}');

          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse: (response, handler) {
          debugPrint('status code: ${response.statusCode}');
          debugPrint('data: ${response.data}');
          // Do something with response data

          log(response.data.toString());

          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          EasyLoading.dismiss();

          debugPrint('statusCode: ${e.response?.statusCode}');
          debugPrint('path: ${e.requestOptions.path}');
          debugPrint('response: ${e.response}');
          debugPrint('data: ${e.response?.data}');
          debugPrint("error ${e.error}");
          debugPrint("message ${e.message}");
          debugPrint("type ${e.type}");

          //
        },
      ),
    );

  }
}