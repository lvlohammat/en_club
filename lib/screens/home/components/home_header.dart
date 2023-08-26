import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/home/components/home_item.dart';
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
    required this.constraints,
  });

  final double maxWidth;
  final List<EnglishItem> items;
  final List<String> names;
  final BoxConstraints constraints;

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
              final itemsByName = context
                  .read<EnglishItems>()
                  .getItemsByName(names[index], items);
              return InkWell(
                onTap: () => chosenItemBottomSheet(
                    context, constraints, names, index, itemsByName),
                child: Container(
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
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<dynamic> chosenItemBottomSheet(
      BuildContext context,
      BoxConstraints constraints,
      List<String> names,
      int index,
      List<EnglishItem> itemsByName) {
    return showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 1,
                  leading: icnBtn(
                    Icons.close,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(names[index]),
                ),
                kDefaultVerticalSizedBox,
                Expanded(
                  child: ListView.builder(
                    itemCount: itemsByName.length,
                    itemBuilder: (context, idx) => HomeItem(
                        isSaved: false,
                        maxWidth: constraints.maxWidth,
                        maxHight: constraints.maxHeight,
                        item: itemsByName[idx]),
                  ),
                )
              ],
            ),
          )),
    );
  }

  IconButton icnBtn(IconData icon, GestureTapCallback press) {
    return IconButton.outlined(
        onPressed: press,
        style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        icon: Icon(icon));
  }
}
