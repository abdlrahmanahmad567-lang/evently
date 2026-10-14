import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/theme/Appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../on_boarding.dart';
import '../widgets/do_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/Onboardingpage';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onNextPressed() {
    if (_currentIndex < OnBoardingData.onboardingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onPreviousPressed() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacementNamed(context, AppRouteName.loginScreen);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final isLastPage = _currentIndex == OnBoardingData.onboardingList.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // Top Bar: Back button | Centered Logo | Skip button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentIndex > 0
                      ? InkWell(
                          onTap: _onPreviousPressed,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Appcolor.lighprimeryColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16.sp,
                              color: Appcolor.lighprimeryColor,
                            ),
                          ),
                        )
                      : SizedBox(width: 36.w, height: 36.h),
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      "assets/image/smal_evently.png",
                      width: 130.w,
                      color: theme.primaryColor,
                    ),
                  ),
                  !isLastPage
                      ? InkWell(
                          onTap: _finishOnboarding,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Appcolor.lighprimeryColor,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(width: 36.w, height: 36.h),
                ],
              ),
              SizedBox(height: 12.h),

              // PageView Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnBoardingData.onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final data = OnBoardingData.onboardingList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Illustration Image
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              data.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Indicator Dots
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              OnBoardingData.onboardingList.length,
                              (i) => DoIndicator(isActive: _currentIndex == i),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Title
                        Text(
                          data.title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Appcolor.lighTextColor,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // Description
                        if (data.description != null)
                          Text(
                            data.description!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF686868),
                              height: 1.5,
                            ),
                          ),
                        SizedBox(height: 16.h),
                      ],
                    );
                  },
                ),
              ),

              // Bottom Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.lighprimeryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: _onNextPressed,
                  child: Text(
                    isLastPage ? "Get started" : "Next",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
