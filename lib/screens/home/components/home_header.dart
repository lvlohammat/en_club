import 'package:english_club/providers/english_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.maxWidth,
    required this.items,
    required this.names,
  });

  final double maxWidth;
  final List<EnglishItem> items;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            names.length,
            (index) {
              final String? imageUrl = context
                  .read<EnglishItems>()
                  .firstItemByName(names[index], items)
                  .imageUrl;
              return Container(
                margin: const EdgeInsets.only(
                  right: 10,
                  bottom: 10,
                  top: 10,
                ),
                height: maxWidth * .25,
                width: maxWidth * .25,
                decoration: BoxDecoration(
                  color: kDarkColorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
