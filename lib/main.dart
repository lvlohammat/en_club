import 'package:english_club/constants.dart';
import 'package:english_club/helpers/back4app.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/detail/detail_screen.dart';
import 'package:english_club/screens/initial/initial_screen.dart';
import 'package:english_club/screens/items/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Back4App.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EnglishItems>(
          create: (context) => EnglishItems(),
        ),
      ],
      child: MaterialApp(
        title: 'English Club',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          progressIndicatorTheme: ProgressIndicatorThemeData(
              color: kDarkColorScheme.onSecondaryContainer),
          textTheme: const TextTheme().copyWith(
              bodyMedium: TextStyle(
                fontSize: 16,
                color: kDarkColorScheme.onBackground,
              ),
              titleLarge: const TextStyle(fontSize: 20)),
          scaffoldBackgroundColor: kDarkColorScheme.surface,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.background,
            foregroundColor: kDarkColorScheme.onBackground,
            centerTitle: true,
          ),
          colorScheme: kDarkColorScheme,
        ),
        home: const InitialScreen(),
        routes: {
          DetailScreen.routeName: (context) => const DetailScreen(),
          ItemsScreen.routeName: (context) => const ItemsScreen(),
          InitialScreen.routeName: (context) => const InitialScreen(),
        },
      ),
    );
  }
}
