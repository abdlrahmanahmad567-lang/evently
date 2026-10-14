import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SelctionItem extends StatelessWidget {
  SelctionItem({
    super.key,
    this.isSelected = false,
    this.title,
    this.onTap,
    this.icon,
  });
  String? title;
  String? icon;
  bool isSelected;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? theme.primaryColor
              : theme.scaffoldBackgroundColor,
          border: Border.all(color: theme.primaryColor, width: 0.5),
        ),
        child: title == null
            ? Image.asset(
                icon!,
                color: isSelected ? Colors.white : theme.primaryColor,
                width: 20.w,
                height: 20.h,
              )
            : Text(
                title!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? Colors.white : theme.primaryColor,
                ),
              ),
      ),
    );
  }
}
