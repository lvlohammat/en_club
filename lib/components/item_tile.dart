import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/english_items.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
  });

  final EnglishItem item;

  @override
  Widget build(BuildContext context) {
    final savedItems = context.watch<EnglishItems>().savedItems;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: item.imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        item.name!,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        tagToString(item.tag!),
        style:
            TextStyle(fontSize: 14, color: kDarkColorScheme.onPrimaryContainer),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<EnglishItems>().saveItem(item);
        },
        icon: Icon(
            savedItems.where((element) => element.id == item.id).isNotEmpty
                ? Icons.bookmark
                : Icons.bookmark_border_rounded),
        color: kDarkColorScheme.primary,
      ),
    );
  }
}
