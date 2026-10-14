import 'package:evently/cor/provider/app_provider.dart';
import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../cor/widgets/custom_Buttom.dart';
import '../Widgets/selction_item.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const String routeName = 'OnboradingScreen';

  @override
  Widget build(BuildContext context) {
    var them = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.w),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: "logo",
                  child: Center(
                    child: Image.asset(
                      "assets/image/smal_evently.png",
                      width: 140.w,
                      color: them.primaryColor,
                    ),
                  ),
                ),
            
                SizedBox(height: 25.h),
                Center(
                  child: Image.asset(
                    "assets/image/evently_png.png",
                    width: 343.w,
                    height: 343.h,
                    color: them.primaryColorLight,
                  ),
                ),
                SizedBox(height: 25.h),
                Text(local.startTitle, style: them.textTheme.titleMedium),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 70.h,
                  child: Text(
                    local.startDesc,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      height: 2,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 24.h),
            
                Row(
                  textDirection: TextDirection.ltr,
            
                  children: [
                    Expanded(
                      child: Text(
                        local.lang,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: them.primaryColor,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    SelctionItem(
                      isSelected: provider.langCode == "ar",
                      title: "Arabic",
                      onTap: () {
                        provider.ChangeLang("ar");
                      },
                    ),
                    SelctionItem(
                      isSelected: provider.langCode == "en",
                      title: "English ",
                      onTap: () {
                        provider.ChangeLang("en");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  spacing: 8.w,
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(
                      child: Text(
                        local.theme,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: them.primaryColor,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    SelctionItem(
                      isSelected: provider.themeMode == ThemeMode.light,
                      icon: "assets/image/sun.png",
                      onTap: () {
                        provider.ChangeTheme(ThemeMode.light);
                      },
                    ),
                    SizedBox(width: 8.w),
                    SelctionItem(
                      isSelected: provider.themeMode == ThemeMode.dark,
                      icon: "assets/image/moon.png",
                      onTap: () {
                        provider.ChangeTheme(ThemeMode.dark);
                      },
                    ),
                  ],
                ),
                 SizedBox(height: 24.h,),
                 CustomButtom(
                  title: 'Let’s start',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouteName. onboardingpage);

                   },
                  isLoding: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
