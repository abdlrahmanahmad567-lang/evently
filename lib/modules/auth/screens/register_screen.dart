import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/modules/auth/manger/auth_Provieder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';

import '../../../cor/widgets/custom_Buttom.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var them = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => AuthProvieder(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<AuthProvieder>(
              builder: (context, Provider, child) {
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

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
                      SizedBox(height: 45.h),

                      Text(
                        textDirection: TextDirection.rtl,
                        "Create your account",
                        style: them.textTheme.titleLarge,
                      ),

                      SizedBox(height: 24.h),
                      TextFormField(
                        controller: Provider.nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter your Name";
                          }
                          return null;
                        },

                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },

                        decoration: InputDecoration(
                          hintText: "Enter your Name",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xff686868),
                          ),

                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icon/user.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: Provider.emailController,
                        validator: (value) {
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value ?? "");

                          if (value == null || value.trim().isEmpty) {
                            return "enterEmail"; // Localized: "Enter Email"
                          } else if (!emailValid) {
                            return "enterValidEmail"; // Localized: "Enter valid Email"
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },

                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xff686868),
                          ),

                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icon/sms.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: Provider.passwordController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enterPassword"; // Localized: "Enter password"
                          } else if (value.length < 6) {
                            return "passwordTooShort"; // Localized: "Enter More Than 6 char"
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        obscureText: true,
                        obscuringCharacter: "*",

                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xff686868),
                          ),

                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icon/lock.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Color(0xff686868),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value != Provider.passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        obscureText: true,
                        obscuringCharacter: "*",

                        decoration: InputDecoration(
                          hintText: "Confirm your password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Color(0xff686868),
                          ),

                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icon/lock.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Color(0xff686868),
                          ),
                        ),
                      ),
                      SizedBox(height: 52.h),
                      CustomButtom(
                        isLoding:Provider.isLoding,
                        title: 'Sign up',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Provider.creatAccount();
                          }
                        },
                       ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: them.textTheme.titleLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: Color(0xff686868),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRouteName.loginScreen,
                              );
                            },
                            child: Text(
                              "Login",
                              style: them.textTheme.titleLarge!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
