import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_club/providers/english_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../components/html_viewer.dart';
import '../../components/item_tile.dart';
import '../../constants.dart';
import '../../helpers/position_data.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
            position: position,
            bufferedPosition: bufferedPosition,
            duration: duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    final playerItem = context.read<EnglishItems>().playerItem;
    _audioPlayer = AudioPlayer()..setUrl(playerItem!.audioUrl!);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EnglishItem item =
        ModalRoute.of(context)?.settings.arguments as EnglishItem;

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
                    item.title!,
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
                      StreamBuilder<PlayerState>(
                        stream: _audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing;
                          if (!(playing ?? false)) {
                            return ElevatedButton.icon(
                                onPressed: _audioPlayer.play,
                                icon: const Icon(
                                    Icons.play_circle_outline_rounded),
                                label: const Text('Play'));
                          } else if (processingState ==
                              ProcessingState.completed) {
                            return ElevatedButton(
                                onPressed: () {},
                                child: const Icon(Icons.check_circle));
                          }
                          return ElevatedButton.icon(
                              onPressed: _audioPlayer.pause,
                              icon: const Icon(
                                  Icons.pause_circle_outline_rounded),
                              label: const Text('Playing'));
                        },
                      ),
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
        onPressed: () {
          showPreviewPlayer(context, item);
        },
        child: const Icon(Icons.remove_red_eye_sharp),
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
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProgressBar(
                  progress: positionData?.position ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                ),
              );
            },
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
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (!(playing ?? false)) {
                    return IconButton(
                      onPressed: _audioPlayer.play,
                      icon: const Icon(
                        Icons.play_arrow_sharp,
                        size: 30,
                      ),
                    );
                  } else if (processingState == ProcessingState.completed) {
                    return IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle,
                          size: 30,
                        ));
                  }
                  return IconButton(
                    onPressed: _audioPlayer.pause,
                    icon: const Icon(
                      Icons.pause,
                      size: 30,
                    ),
                  );
                },
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
