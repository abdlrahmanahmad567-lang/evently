
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {

  String langCode = 'en';

  bool get isDark => themeMode == ThemeMode.dark;


  void ChangeLang ( String code){
    langCode = code;
    notifyListeners();


  }


ThemeMode themeMode = ThemeMode.light;
  void ChangeTheme(ThemeMode  mode  ){
  themeMode = mode;
  notifyListeners();
  }

}
