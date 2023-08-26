import 'package:english_club/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/english_items.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});
  static const routeName = '/initial';

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late Future fetchData;
  @override
  void initState() {
    super.initState();
    fetchData = context.read<EnglishItems>().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(
              backgroundColor: const Color(0xff161616),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cat.gif',
                    fit: BoxFit.cover,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          default:
            if (snapshot.hasError) {
              return const Scaffold(
                backgroundColor: Color(0xff161616),
                body: Center(
                  child: Text(
                    'Failed to fetch data',
                  ),
                ),
              );
            } else {
              return const HomeScreen();
            }
        }
      },
    );
  }
}
