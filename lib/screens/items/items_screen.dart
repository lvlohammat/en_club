import 'package:english_club/screens/items/components/items_body.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});
  static const routeName = '/items';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> items =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final bool isSaved = items['title'] == 'Subscription' ? true : false;

    return Scaffold(
      appBar: AppBar(
        title: Text(items['title']),
      ),
      body: ItemsBody(
        items: items['items'],
        isSaved: isSaved,
      ),
    );
  }
}
