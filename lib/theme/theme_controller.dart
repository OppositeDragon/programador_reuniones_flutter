import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/theme/theme_data.dart';

final themeProvider = ChangeNotifierProvider<ThemeController>((ref) {
  return ThemeController();
});

class ThemeController with ChangeNotifier {
  final ThemeData _lightThemeData = ThemeData(colorScheme: lightColorScheme);
  final ThemeData _darkThemeData = ThemeData(colorScheme: darkColorScheme);

  ThemeData get themeData => _isDark ? _darkThemeData : _lightThemeData;
  bool _isDark = false;
	bool get isDark => _isDark;
  setTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
