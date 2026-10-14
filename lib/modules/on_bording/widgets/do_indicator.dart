import 'package:evently/cor/theme/Appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoIndicator extends StatelessWidget {
  const DoIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      duration: const Duration(milliseconds: 250),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? Appcolor.lighprimeryColor
            : const Color(0xFFD0D5DD),
        borderRadius: BorderRadius.circular(27.r),
      ),
    );
  }
}
