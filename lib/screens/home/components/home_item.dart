import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../components/item_tile.dart';
import '../../../constants.dart';
import '../../../providers/theme_provider.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({
    super.key,
    required this.maxWidth,
    required this.maxHight,
    required this.item,
    required this.isSaved,
  });

  final double maxWidth;
  final double maxHight;
  final EnglishItem item;
  final bool? isSaved;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  late String title;
  @override
  void initState() {
    super.initState();
    final extractedTitle = widget.item.title!;
    if (extractedTitle.contains(widget.item.name!)) {
      title = extractedTitle.split('${widget.item.name!}: ')[1];
    } else {
      title = 'Part ${widget.item.episode}: $extractedTitle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final themeProvider = context.read<ThemeProvider>();
    final lightColorScheme = themeProvider.lightColorScheme;
    final darkColorScheme = themeProvider.darkColorScheme;
    return InkWell(
      splashColor: isDarkMode
          ? darkColorScheme.secondaryContainer
          : lightColorScheme.secondaryContainer,
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName, arguments: {
          'id': widget.item.id,
          'isSaved': widget.isSaved ?? false
        });
        context.read<EnglishItems>().changePlayerItem(widget.item);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemTile(item: widget.item),
          kDefaultVerticalSizedBox,
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Html(
            data: widget.item.story!,
            style: {
              'body': Style(
                  margin: Margins.all(0),
                  fontSize: FontSize(16),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis),
              'strong': Style(
                  margin: Margins.all(0),
                  fontSize: FontSize(16),
                  color: isDarkMode
                      ? darkColorScheme.onPrimaryContainer
                      : lightColorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.normal),
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
