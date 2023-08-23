import 'package:english_club/components/search_bar.dart';
import 'package:english_club/constants.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/filtred/filtred_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          kDefaultVerticalSizedBox,
          AppBar(
              title: CustomSearch(
            items: items,
          )),
          kDefaultVerticalSizedBox,
          ExpansionTile(
            backgroundColor: kDarkColorScheme.secondaryContainer,
            collapsedBackgroundColor: kDarkColorScheme.secondaryContainer,
            textColor: kDarkColorScheme.onSecondaryContainer,
            iconColor: kDarkColorScheme.onSecondaryContainer,
            collapsedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: const Icon(
              Icons.apps_sharp,
              size: 30,
            ),
            title: const Text(
              'Category',
              style: TextStyle(fontSize: 25),
            ),
            children: const [
              TagTile(
                icon: Icons.theater_comedy_rounded,
                tag: Tag.drama,
              ),
              TagTile(
                icon: Icons.work,
                tag: Tag.business,
              ),
            ],
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
    return ListTile(
      textColor: kDarkColorScheme.onSecondaryContainer,
      iconColor: kDarkColorScheme.onSecondaryContainer,
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        tagToString(tag),
        style: const TextStyle(fontSize: 20),
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
