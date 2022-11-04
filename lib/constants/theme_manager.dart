import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _thememMode = ThemeMode.light;

  get themeMode => _thememMode;
  toggleTheme(bool isDark) {
    _thememMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
