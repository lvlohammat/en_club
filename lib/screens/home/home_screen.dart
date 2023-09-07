import 'package:english_club/screens/explore/explore_screen.dart';
import 'package:english_club/screens/home/components/home_body.dart';
import 'package:english_club/screens/library/components/library_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const HomeBody(),
    const ExploreScreen(),
    const LibraryBody(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final themeProvider = context.read<ThemeProvider>();
    final lightColorScheme = themeProvider.lightColorScheme;
    final darkColorScheme = themeProvider.darkColorScheme;
    return Scaffold(
      appBar: _currentIndex == 1
          ? null
          : AppBar(
              title: Text(
                'English Club',
                style: TextStyle(
                    color: isDarkMode
                        ? darkColorScheme.onSecondaryContainer
                        : lightColorScheme.onSecondaryContainer),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<ThemeProvider>().toggleThemeMode();
                  },
                  icon: Icon(
                    isDarkMode ? Icons.mode_night_rounded : Icons.sunny,
                    color: isDarkMode
                        ? darkColorScheme.onSecondaryContainer
                        : lightColorScheme.onSecondaryContainer,
                  ),
                )
              ],
            ),
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: isDarkMode
            ? darkColorScheme.background
            : lightColorScheme.background,
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) => setState(() {
          _currentIndex = value;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
          NavigationDestination(
              icon: Icon(Icons.video_library_outlined), label: 'Library'),
        ],
      ),
    );
  }
}
