import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/items/components/items_body.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});
  static const routeName = '/items';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> datas =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final bool isSaved = datas['title'] == 'Subscription' ? true : false;
    final List<EnglishItem> items = datas['items'];

    return Scaffold(
      appBar: AppBar(
        title: Text(datas['title']),
      ),
      body: items.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "You don't have any saved items yet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            )
          : ItemsBody(
              items: items,
              isSaved: isSaved,
            ),
    );
  }
}
