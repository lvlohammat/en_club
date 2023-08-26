import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/constants.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:english_club/screens/home/components/home_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsBody extends StatelessWidget {
  const ItemsBody({super.key, required this.items, required this.isSaved});
  final List<EnglishItem> items;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    final names = context.watch<EnglishItems>().getNameOfItems(items);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GridView.builder(
            itemCount: names.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxWidth,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = context
                  .read<EnglishItems>()
                  .firstItemByName(names[index], items);
              final itemsByName = context
                  .read<EnglishItems>()
                  .getItemsByName(names[index], items);
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => chosenItemBottomSheet(
                          context, constraints, names, index, itemsByName),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          right: 15, left: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: kDarkColorScheme.secondaryContainer
                              .withOpacity(.8)),
                      child: Text(
                        names[index],
                        style: TextStyle(
                            fontSize: 22,
                            color: kDarkColorScheme.onSecondaryContainer),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
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
                      isSaved: isSaved,
                      maxWidth: constraints.maxWidth,
                      maxHight: constraints.maxHeight,
                      item: itemsByName[idx]),
                ),
              )
            ],
          ),
        ),
      ),
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
