import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../components/item_tile.dart';
import '../../../constants.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.maxWidth,
    required this.maxHight,
    required this.item,
  });

  final double maxWidth;
  final double maxHight;
  final EnglishItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kDarkColorScheme.secondaryContainer,
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName, arguments: item);
        context.read<EnglishItems>().changePlayerItem(item);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemTile(item: item),
          kDefaultVerticalSizedBox,
          Text(
            item.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Html(
            data: item.story!,
            style: {
              'body': Style(
                  margin: Margins.all(0),
                  fontSize: FontSize(16),
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis),
              'strong': Style(
                  margin: Margins.all(0),
                  fontSize: FontSize(16),
                  color: kDarkColorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.normal),
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
