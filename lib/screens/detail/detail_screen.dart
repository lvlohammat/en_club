import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/helpers/audio_helper.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/html_viewer.dart';
import '../../components/item_tile.dart';
import '../../constants.dart';
import 'components/custom_play_button.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;
  late final AudioHelper _audioPlayer;
  late String title;

  @override
  void initState() {
    super.initState();
    final playerItem = context.read<EnglishItems>().playerItem;
    _audioPlayer = AudioHelper(playerItem!.audioUrl!);
    final extractedTitle = playerItem.title!;
    if (extractedTitle.contains(playerItem.name!)) {
      title = extractedTitle.split('${playerItem.name!}: ')[1];
    } else {
      title = 'Part ${playerItem.episode}: $extractedTitle';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recivedItemDatas =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final item = context
        .read<EnglishItems>()
        .findById(recivedItemDatas['id'], recivedItemDatas['isSaved']);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            title: Text(item.name!),
          ),
          SliverToBoxAdapter(
              child: LayoutBuilder(
            builder: (context, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ItemTile(item: item),
                ),
                kDefaultVerticalSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                kDefaultVerticalSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomPlayButton(
                          audioPlayer: _audioPlayer, isShorten: false),
                      CupertinoSlidingSegmentedControl(
                        backgroundColor: kDarkColorScheme.surface,
                        thumbColor:
                            kDarkColorScheme.primaryContainer.withOpacity(0.5),
                        children: {
                          0: Text(
                            'Script',
                            style: TextStyle(
                                color: kDarkColorScheme.onSecondaryContainer),
                          ),
                          1: Text(
                            'Lesson',
                            style: TextStyle(
                                color: kDarkColorScheme.onSecondaryContainer),
                          )
                        },
                        groupValue: selectedIndex,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        onValueChanged: (value) {
                          setState(() {
                            selectedIndex = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                kDefaultVerticalSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HtmlTextViewer(
                    text: item.story,
                    fontSize: 18,
                    maxLine: 100,
                    normalColor: kDarkColorScheme.primary,
                    boldColor: kDarkColorScheme.primary,
                  ),
                ),
                kDefaultVerticalSizedBox,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          kDarkColorScheme.secondaryContainer.withOpacity(.5)),
                  child: HtmlTextViewer(
                    text: selectedIndex == 0 ? item.script : item.lesson,
                    fontSize: 25,
                    maxLine: 100,
                    normalColor: kDarkColorScheme.onSecondaryContainer,
                    boldColor: kDarkColorScheme.primary,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDarkColorScheme.secondaryContainer,
        onPressed: () {
          showPreviewPlayer(context, item);
        },
        child: ValueListenableBuilder<ButtonState>(
          valueListenable: _audioPlayer.buttonNotifier,
          builder: (context, value, child) {
            switch (value) {
              case ButtonState.paused:
                return Lottie.asset(
                  'assets/lottie/playing.json',
                  animate: false,
                  reverse: true,
                );
              case ButtonState.playing:
                return Lottie.asset('assets/lottie/playing.json');
              case ButtonState.loading:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> showPreviewPlayer(BuildContext context, EnglishItem item) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: kDarkColorScheme.surface,
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.title!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: kDarkColorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            tagToString(item.tag!),
            style: TextStyle(
                color: kDarkColorScheme.onSurface, fontWeight: FontWeight.w300),
          ),
          ValueListenableBuilder<ProgressBarState>(
            valueListenable: _audioPlayer.progressNotifier,
            builder: (context, value, child) => ProgressBar(
              progress: value.current,
              total: value.total,
              buffered: value.buffered,
              timeLabelLocation: TimeLabelLocation.sides,
              onSeek: _audioPlayer.seek,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // _audioPlayer.seek();
                },
                icon: const Icon(
                  Icons.replay_5,
                  size: 30,
                ),
              ),
              CustomPlayButton(
                audioPlayer: _audioPlayer,
                isShorten: true,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.forward_5,
                  size: 30,
                ),
              ),
            ],
          ),
          kDefaultVerticalSizedBox
        ],
      ),
    );
  }
}
