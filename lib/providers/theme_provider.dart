import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  bool isDarkMode = true;

  final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
  );

  final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
  );

  void toggleThemeMode() {
    isDarkMode = !isDarkMode;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ThemeProvider().darkColorScheme.onSecondaryContainer),
    textTheme: const TextTheme().copyWith(
        bodyMedium: TextStyle(
          fontSize: 16,
          color: ThemeProvider().darkColorScheme.onBackground,
        ),
        titleLarge: const TextStyle(fontSize: 20)),
    scaffoldBackgroundColor: ThemeProvider().darkColorScheme.surface,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: ThemeProvider().darkColorScheme.background,
      foregroundColor: ThemeProvider().darkColorScheme.onBackground,
      centerTitle: true,
    ),
    colorScheme: ThemeProvider().darkColorScheme,
  );
  static final lightTheme = ThemeData().copyWith(
    useMaterial3: true,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ThemeProvider().lightColorScheme.onSecondaryContainer),
    textTheme: const TextTheme().copyWith(
        bodyMedium: TextStyle(
          fontSize: 16,
          color: ThemeProvider().lightColorScheme.onBackground,
        ),
        titleLarge: const TextStyle(fontSize: 20)),
    scaffoldBackgroundColor: ThemeProvider().lightColorScheme.background,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: ThemeProvider().lightColorScheme.background,
      foregroundColor: ThemeProvider().lightColorScheme.onBackground,
      centerTitle: true,
    ),
    colorScheme: ThemeProvider().lightColorScheme,
  );
}
