import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/widgets/custom_Buttom.dart' show CustomButtom;
import 'package:evently/modules/auth/manger/auth_Provieder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (context) => AuthProvieder(),

      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Text(
                        local.loginTitle, // Localized: "Login to your account"
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: 24.h),
                      TextFormField(
                        controller: Provider.emailController,
                        validator: (value) {
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value ?? "");

                          if (value == null || value.trim().isEmpty) {
                            return local.enterEmail; // Localized: "Enter Email"
                          } else if (!emailValid) {
                            return local
                                .enterValidEmail; // Localized: "Enter valid Email"
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText:
                              local.emailHint, // Localized: "Enter your email"
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xff686868),
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
                      SizedBox(height: 24.h),
                      TextFormField(
                        controller: Provider.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return local
                                .enterPassword; // Localized: "Enter password"
                          } else if (value.length < 6) {
                            return local
                                .passwordTooShort; // Localized: "Enter More Than 6 char"
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          hintText: local
                              .passwordHint, // Localized: "Enter your password"
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xff686868),
                          ),
                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icon/lock.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.visibility_off,
                            color: Color(0xff686868),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouteName.forgetPassword,
                            );
                          },
                          child: Text(
                            local
                                .forgetPassword, // Localized: "Forget Password?"
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 47.h),
                      CustomButtom(
                        isLoding: Provider.isLoding,
                        title: local.login, // Localized: "Login"
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Provider.login();

                           }
                          },
                      ),
                      SizedBox(height: 47.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            local
                                .dontHaveAccount, // Localized: "Don't have an account?"
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: const Color(0xff686868),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRouteName.registerScreen,
                              );
                            },
                            child: Text(
                              local.signUp, // Localized: "Signup"
                              style: theme.textTheme.titleLarge!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),
                      CustomButtom(
                        isLoding: Provider.isLoding,
                        title: 'Login With Google',
                        onPressed: () {
                          Provider.signInWithGoogle();
                        },
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
