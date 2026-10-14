import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/modules/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../modules/auth/screens/forget_password.dart';
import '../../modules/auth/screens/register_screen.dart';
import '../../modules/event/models/event_model.dart';
import '../../modules/event/screens/edit_event_screen.dart';
import '../../modules/event/screens/event_details_screen.dart';
import '../../modules/event/screens/event_screen.dart';
import '../../modules/layout/screens/layout_scrreen.dart';
import '../../modules/on_bording/screens/on_boarding_screen.dart';
import '../../modules/screen/splash_screen.dart';
import '../../modules/start/screen/start_screen.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRouteName.SplashScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case AppRouteName.startScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const StartScreen();
          },
        );
      case AppRouteName.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        );
      case AppRouteName.registerScreen:
        return MaterialPageRoute(
          builder: (context) {
            return RegisterScreen();
          },
        );
      case AppRouteName.forgetPassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgetPassword();
          },
        );
      case AppRouteName.layoutScrreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LayoutScrreen();
          },
        );
      case AppRouteName.onboardingpage:
        return MaterialPageRoute(
          builder: (context) {
            return const OnBoardingScreen();
          },
        );      case AppRouteName.EventScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const EventScreen();
          },
        );
      case AppRouteName.eventDetailsScreen:
        final event = setting.arguments as EventModel;
        return MaterialPageRoute(
          builder: (context) {
            return EventDetailsScreen(event: event);
          },
        );
      case AppRouteName.editEventScreen:
        final event = setting.arguments as EventModel;
        return MaterialPageRoute(
          builder: (context) {
            return EditEventScreen(event: event);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
