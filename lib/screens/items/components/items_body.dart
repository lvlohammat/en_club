import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/constants.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsBody extends StatelessWidget {
  const ItemsBody({super.key, required this.items});
  final List<EnglishItem> items;

  @override
  Widget build(BuildContext context) {
    final names = context.read<EnglishItems>().getNameOfItems(items);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        // final double maxHeight = constraints.maxHeight;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GridView.builder(
            itemCount: names.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxWidth,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = context
                  .read<EnglishItems>()
                  .firstItemByName(names[index], items);
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          right: 15, left: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: kDarkColorScheme.primaryContainer),
                      child: Text(
                        names[index],
                        style: TextStyle(
                            fontSize: 22,
                            color: kDarkColorScheme.onSecondaryContainer),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
