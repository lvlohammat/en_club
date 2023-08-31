import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/items/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryBody extends StatelessWidget {
  const LibraryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () => Navigator.pushNamed(context, ItemsScreen.routeName,
              arguments: {
                'title': 'Subscription',
                'items': context.read<EnglishItems>().savedItems
              }),
          leading: const Icon(Icons.play_arrow_outlined),
          title: const Text(
            'Subscription',
            style: TextStyle(fontSize: 22),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        // const Divider(),
        // const ListTile(
        //   leading: Icon(Icons.arrow_circle_down_rounded),
        //   title: Text(
        //     'Download',
        //     style: TextStyle(fontSize: 22),
        //   ),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        // const Divider()
      ],
    );
  }
}
