import 'package:english_club/constants.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/home/components/home_header.dart';
import 'package:english_club/screens/home/components/home_item.dart';
import 'package:english_club/screens/items/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EnglishItems>(
      builder: (context, english, child) => LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHight = constraints.maxHeight;
          return english.items.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                          'Nothing to show. Please refresh the page'),
                    ),
                    kDefaultVerticalSizedBox,
                    ElevatedButton(
                        onPressed: () => english.fetchItems(),
                        child: const Text('Refresh'))
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Recently Added',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ItemsScreen.routeName,
                                          arguments: {
                                            'title': 'Recently Added',
                                            'items': context
                                                .read<EnglishItems>()
                                                .items
                                          });
                                    },
                                    child: const Text('More'))
                              ],
                            ),
                            HomeHeader(
                              names: english.getNameOfItems(english.items),
                              maxWidth: maxWidth,
                              items: english.items,
                              constraints: constraints,
                            ),
                            const Divider(),
                            ...List.generate(
                              english.items.length,
                              (index) => HomeItem(
                                isSaved: false,
                                maxWidth: maxWidth,
                                maxHight: maxHight,
                                item: english.items[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
