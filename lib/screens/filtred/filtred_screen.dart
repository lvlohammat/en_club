import 'package:english_club/providers/english_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../detail/detail_screen.dart';

class FiltredScreen extends StatefulWidget {
  const FiltredScreen({
    super.key,
    required this.tag,
  });
  static const routeName = '/filtred';
  final Tag tag;

  @override
  State<FiltredScreen> createState() => _FiltredScreenState();
}

class _FiltredScreenState extends State<FiltredScreen> {
  late Future _fetchFiltredItems;
  @override
  void initState() {
    super.initState();
    _fetchFiltredItems =
        context.read<EnglishItems>().fetchFiltredItems(widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _fetchFiltredItems,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              } else {
                return Consumer<EnglishItems>(
                  builder: (context, english, child) => LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: ListView.builder(
                        itemCount:
                            english.getNameOfItems(english.filtredItems).length,
                        itemBuilder: (context, index) {
                          final names =
                              english.getNameOfItems(english.filtredItems);
                          final items = english.getItemsByName(
                              names[index], english.filtredItems);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            child: ExpansionTile(
                              backgroundColor: kDarkColorScheme
                                  .secondaryContainer
                                  .withOpacity(.5),
                              collapsedBackgroundColor: kDarkColorScheme
                                  .secondaryContainer
                                  .withOpacity(.5),
                              textColor: kDarkColorScheme.onSecondaryContainer,
                              iconColor: kDarkColorScheme.onSecondaryContainer,
                              collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              title: Text(
                                names[index],
                                style: const TextStyle(fontSize: 25),
                              ),
                              children: items
                                  .map(
                                    (item) => ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DetailScreen.routeName,
                                            arguments: item);
                                        context
                                            .read<EnglishItems>()
                                            .changePlayerItem(item);
                                      },
                                      title: Text(
                                        item.title!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
