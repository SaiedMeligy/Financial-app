import 'package:flutter/material.dart';

class AppThemeManager{
  static const primaryColor = Color(0xffCCA86A);
  //0xff2B455F
  //#CA961C
  //#CCA86A
  //#F0BF4C
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
        color: primaryColor,
        padding: EdgeInsets.zero
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.w300,
        color: Colors.white,
        fontSize: 14,
      ),
    ),

  );

}