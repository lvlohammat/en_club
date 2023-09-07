import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  bool isDarkMode = true;

  final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
  );

  final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
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
      backgroundColor: ThemeProvider().darkColorScheme.surface,
      foregroundColor: ThemeProvider().darkColorScheme.onSecondaryContainer,
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
    scaffoldBackgroundColor: ThemeProvider().lightColorScheme.surface,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: ThemeProvider().lightColorScheme.surface,
      foregroundColor: ThemeProvider().lightColorScheme.onSecondaryContainer,
      centerTitle: true,
    ),
    colorScheme: ThemeProvider().lightColorScheme,
  );
}
