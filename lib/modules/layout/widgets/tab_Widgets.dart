import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidgets extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const TabWidgets({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? theme.primaryColor : Colors.white,
        border: Border.all(
          color: isSelected ? theme.primaryColor : Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isSelected ? Colors.white : theme.primaryColor,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : theme.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

