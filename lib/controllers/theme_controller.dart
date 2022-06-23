import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/theme_constants.dart';

final themeProvider = ChangeNotifierProvider<ThemeController>((ref) {
  return ThemeController();
});

class ThemeController with ChangeNotifier {
  final ThemeData _lightThemeData = ThemeData(colorScheme: lightColorScheme);
  final ThemeData _darkThemeData = ThemeData(colorScheme: darkColorScheme);

  ThemeData get themeData => _themeData;
  ThemeData _themeData = ThemeData(colorScheme: lightColorScheme);

  bool get isDark => _themeData == ThemeData(colorScheme: darkColorScheme);

  setTheme(bool value) {
    if (_themeData == ThemeData(colorScheme: darkColorScheme)) {
      _themeData = _lightThemeData;
    } else {
      _themeData = _darkThemeData;
    }

    notifyListeners();
  }
}
