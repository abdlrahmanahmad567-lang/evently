import 'package:evently/cor/routes/app_route.dart';
import 'package:evently/cor/theme/app_Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'cor/provider/app_provider.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'modules/screen/splash_screen.dart';
import 'modules/start/screen/start_screen.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder:  (context, child) {

        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            var provider = Provider.of<AppProvider>(context);
            return MaterialApp(
              navigatorKey:navigatorKey ,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              locale: Locale(provider.langCode),
              themeMode: provider.themeMode ,
               theme:AppTheme.light,
              darkTheme:AppTheme.dark,
              debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoute.onGenerateRoute,
            );
          },
        );
      }   ,

    );
  }
}
