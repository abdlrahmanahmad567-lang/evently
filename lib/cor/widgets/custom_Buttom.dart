import 'package:evently/cor/theme/Appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButtom extends StatelessWidget {
   CustomButtom({super.key, required this.title,
     this.isLoding = false,
     required this.onPressed,});

  String title;
  void Function()? onPressed;
  bool isLoding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        color: Appcolor.lighprimeryColor ,
        foregroundColor: Colors.white,
        disabledColor:Appcolor.lighprimeryColor  ,
        borderRadius: BorderRadius.circular(16.r),
        onPressed: isLoding ? null : onPressed,
        child: AnimatedCrossFade(
          firstChild: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          secondChild: CupertinoActivityIndicator(color: Colors.white),
          crossFadeState: isLoding
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
