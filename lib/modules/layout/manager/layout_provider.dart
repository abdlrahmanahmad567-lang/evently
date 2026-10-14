import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  int tabIndex = 0;

  void onTabChange(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
