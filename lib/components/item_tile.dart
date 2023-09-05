import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/english_items.dart';
import '../providers/theme_provider.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
  });

  final EnglishItem item;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final savedItems = context.watch<EnglishItems>().savedItems;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeProvider.isDarkMode
                  ? themeProvider.darkColorScheme.secondaryContainer
                  : themeProvider.lightColorScheme.secondaryContainer
                      .withOpacity(.5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        item.name!,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        tagToString(item.tag!)[0].toUpperCase() +
            tagToString(item.tag!).substring(1),
        style: TextStyle(
            fontSize: 14,
            color: themeProvider.isDarkMode
                ? themeProvider.darkColorScheme.onPrimaryContainer
                : themeProvider.lightColorScheme.onPrimaryContainer),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<EnglishItems>().saveItem(item);
        },
        icon: Icon(
            savedItems.where((element) => element.id == item.id).isNotEmpty
                ? Icons.bookmark
                : Icons.bookmark_border_rounded),
        color: themeProvider.isDarkMode
            ? themeProvider.darkColorScheme.primary
            : themeProvider.lightColorScheme.primary,
      ),
    );
  }
}
