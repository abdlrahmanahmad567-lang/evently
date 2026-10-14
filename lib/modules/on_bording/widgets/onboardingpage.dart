import 'package:evently/cor/theme/Appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../on_boarding.dart';

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({
    super.key,
    required this.onBoardingData,
  });

  final OnBoardingData onBoardingData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                onBoardingData.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            onBoardingData.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Appcolor.lighTextColor,
            ),
          ),
          SizedBox(height: 10.h),
          if (onBoardingData.description != null)
            Text(
              onBoardingData.description!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF686868),
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
