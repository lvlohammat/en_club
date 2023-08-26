import 'package:english_club/providers/english_items.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/custom_tile_view.dart';

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
              return Center(
                child: Lottie.asset('assets/lottie/cat.json',
                    width: 100, height: 100, fit: BoxFit.contain),
              );
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
                                vertical: 5, horizontal: 7),
                            child: CustomTileView(
                              names: names,
                              items: items,
                              index: index,
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
