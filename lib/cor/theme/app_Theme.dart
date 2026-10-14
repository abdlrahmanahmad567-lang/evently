import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Appcolor.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Appcolor.lighBgColor,
    primaryColor: Appcolor.lighprimeryColor,
    primaryColorLight: Appcolor.lighprimeryColor,
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Appcolor.lighprimeryColor,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Appcolor.lighprimeryColor,
      ),
      titleMedium: TextStyle(
        color: Appcolor.lighTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
        bodyMedium: TextStyle(
            color: Colors.black
        )
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.lighprimeryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.lighprimeryColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.lighprimeryColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.lighprimeryColor),
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Appcolor.darkBgColor,
    primaryColor: Appcolor.darkprimeryColor,
    primaryColorLight: Colors.white,
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 16, color: Colors.white),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Appcolor.darkBgColor,
      selectedItemColor: Appcolor.darkprimeryColor,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: Appcolor.darkTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
      bodyMedium: TextStyle(
        color: Colors.white
      )
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.darkprimeryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.darkprimeryColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.darkprimeryColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Appcolor.darkprimeryColor),
      ),
    ),
  );
}
