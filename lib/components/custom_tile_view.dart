import 'package:english_club/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/english_items.dart';
import '../screens/detail/detail_screen.dart';

class CustomTileView extends StatelessWidget {
  const CustomTileView({
    super.key,
    required this.names,
    required this.items,
    required this.index,
    this.isExpanded,
  });

  final List<String> names;
  final List<EnglishItem> items;
  final int index;
  final bool? isExpanded;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    return ExpansionTile(
      initiallyExpanded: isExpanded ?? false,
      backgroundColor: themeProvider.isDarkMode
          ? themeProvider.darkColorScheme.secondaryContainer.withOpacity(.5)
          : themeProvider.lightColorScheme.secondaryContainer.withOpacity(.5),
      collapsedBackgroundColor: themeProvider.isDarkMode
          ? themeProvider.darkColorScheme.secondaryContainer.withOpacity(.5)
          : themeProvider.lightColorScheme.secondaryContainer.withOpacity(.5),
      textColor: themeProvider.isDarkMode
          ? themeProvider.darkColorScheme.onSecondaryContainer
          : themeProvider.lightColorScheme.onSecondaryContainer,
      iconColor: themeProvider.isDarkMode
          ? themeProvider.darkColorScheme.onSecondaryContainer
          : themeProvider.lightColorScheme.onSecondaryContainer,
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(
        names[index],
        style: const TextStyle(fontSize: 25),
      ),
      children: items
          .map(
            (item) => ListTile(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName,
                    arguments: {'id': item.id, 'isSaved': false});

                context.read<EnglishItems>().changePlayerItem(item);
              },
              title: Text(
                item.title!,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
          .toList(),
    );
  }
}
