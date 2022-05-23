import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/theme/theme_data.dart';

final themeProvider = ChangeNotifierProvider<ThemeController>((ref) {
  return ThemeController();
});

class ThemeController with ChangeNotifier {
  final ThemeData _lightThemeData = ThemeData(colorScheme: lightColorScheme);
  final ThemeData _darkThemeData = ThemeData(colorScheme: darkColorScheme);
  ThemeData _themeData = ThemeData(colorScheme: lightColorScheme);

  ThemeData get themeData => _themeData;
  bool _isDark = true;
  setTheme() {
    _themeData = _isDark ? _darkThemeData : _lightThemeData;
    _isDark = !_isDark;
    notifyListeners();
  }
}
