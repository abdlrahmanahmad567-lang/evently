import 'package:evently/cor/theme/Appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

class Toast {
  static void show({required String title, ToastTyp typ = ToastTyp.success}) {
    if (navigatorKey.currentContext == null) return;
    ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: typ == ToastTyp.error
            ? Colors.red.shade700
            : Appcolor.lighprimeryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        content: Row(
          children: [
            Icon(
              typ == ToastTyp.success
                  ? Icons.check_circle_outline_rounded
                  : Icons.error_outline_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ToastTyp { error, success }
