import 'package:english_club/constants.dart';
import 'package:english_club/screens/explore/explore_screen.dart';
import 'package:english_club/screens/home/components/home_body.dart';
import 'package:english_club/screens/library/components/library_body.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: _currentIndex == 1
          ? null
          : AppBar(
              title: const Text('English Club'),
            ),
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kDarkColorScheme.background,
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
