import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key, required this.items});
  final List<EnglishItem> items;

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String? searchText;
  Iterable<Widget> getSuggestions(
      SearchController controller, List<EnglishItem> savedItems) {
    final String input = controller.value.text;
    return widget.items
        .where((item) => item.title!.toLowerCase().contains(input))
        .map((filteredItem) => ListTile(
              leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(filteredItem.imageUrl!)),
              title: Text(filteredItem.title!),
              trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    controller.text = filteredItem.title!;
                    controller.selection =
                        TextSelection.collapsed(offset: controller.text.length);
                  }),
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName,
                    arguments: {
                      'id': filteredItem.id,
                      'isSaved': savedItems.contains(filteredItem)
                    });
                context.read<EnglishItems>().changePlayerItem(filteredItem);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    final savedItems = context.watch<EnglishItems>().savedItems;
    return SearchAnchor.bar(
      barHintText: 'Type to search',
      suggestionsBuilder: (context, controller) {
        if (controller.text.isEmpty) {
          return [''].map((e) => const Text(''));
        }
        return getSuggestions(controller, savedItems);
      },
    );
  }
}
