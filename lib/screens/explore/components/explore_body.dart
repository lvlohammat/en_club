import 'package:english_club/components/search_bar.dart';
import 'package:english_club/constants.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/filtred/filtred_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class ExploreBody extends StatefulWidget {
  const ExploreBody({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<ExploreBody> createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  Widget build(BuildContext context) {
    final items = context.read<EnglishItems>().items;
    final bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final themeProvider = context.read<ThemeProvider>();
    final lightColorScheme = themeProvider.lightColorScheme;
    final darkColorScheme = themeProvider.darkColorScheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          kDefaultVerticalSizedBox,
          AppBar(
              title: CustomSearch(
            items: items,
          )),
          kDefaultVerticalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ExpansionTile(
              backgroundColor: isDarkMode
                  ? darkColorScheme.secondaryContainer.withOpacity(.5)
                  : lightColorScheme.secondaryContainer.withOpacity(.5),
              collapsedBackgroundColor: isDarkMode
                  ? darkColorScheme.secondaryContainer.withOpacity(.5)
                  : lightColorScheme.secondaryContainer.withOpacity(.5),
              textColor: isDarkMode
                  ? darkColorScheme.onSecondaryContainer
                  : lightColorScheme.onSecondaryContainer,
              iconColor: isDarkMode
                  ? darkColorScheme.onSecondaryContainer
                  : lightColorScheme.onSecondaryContainer,
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(
                Icons.apps_sharp,
                size: 23,
              ),
              title: const Text(
                'Category',
                style: TextStyle(fontSize: 20),
              ),
              children: const [
                TagTile(
                  icon: Icons.theater_comedy_rounded,
                  tag: Tag.drama,
                ),
                TagTile(
                  icon: Icons.work_rounded,
                  tag: Tag.business,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TagTile extends StatelessWidget {
  const TagTile({
    super.key,
    required this.icon,
    required this.tag,
  });
  final IconData icon;
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final themeProvider = context.read<ThemeProvider>();
    final lightColorScheme = themeProvider.lightColorScheme;
    final darkColorScheme = themeProvider.darkColorScheme;
    return ListTile(
      textColor: isDarkMode
          ? darkColorScheme.onSecondaryContainer
          : lightColorScheme.onSecondaryContainer,
      iconColor: isDarkMode
          ? darkColorScheme.onSecondaryContainer
          : lightColorScheme.onSecondaryContainer,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        tagToString(tag),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FiltredScreen(tag: tag),
        ),
      ),
    );
  }
}
