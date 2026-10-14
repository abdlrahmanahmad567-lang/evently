import 'package:animate_do/animate_do.dart';
import 'package:evently/cor/routes/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../start/screen/start_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ZoomIn(
                duration: Duration(seconds: 2),
                child: Hero(
                  tag: "logo",
                  child: Center(
                    child: Image.asset(
                      "assets/image/Evently.png",
                      width: 309.w,
                    ),
                  ),
                ),
              ),
            ),
            FadeInUp(
              delay: Duration(seconds: 2),
              onFinish: (direction) {
                Navigator.pushReplacementNamed(
                  context,
                  AppRouteName.startScreen ,
                );

                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouteName.startScreen,
                    );
                  } else {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouteName.layoutScrreen,
                    );
                  }
              },
              child: Center(
                child: Image.asset("assets/image/Route_Logo.png", width: 214.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
