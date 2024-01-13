import 'package:flutter/material.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 2;

  int get currentIndex => _currentIndex;

  set setcurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
