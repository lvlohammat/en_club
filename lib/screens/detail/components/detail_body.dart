// import 'package:english_club/components/item_tile.dart';
// import 'package:english_club/components/preview_player.dart';
// import 'package:english_club/constants.dart';
// import 'package:english_club/providers/english_items.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../../components/html_viewer.dart';
// import '../../../helpers/position_data.dart';

// class DetailBody extends StatefulWidget {
//   const DetailBody({super.key, required this.item});
//   final EnglishItem item;

//   @override
//   State<DetailBody> createState() => _DetailBodyState();
// }

// class _DetailBodyState extends State<DetailBody> {
//   int selectedIndex = 0;
//   late AudioPlayer _audioPlayer;

//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//         _audioPlayer.positionStream,
//         _audioPlayer.bufferedPositionStream,
//         _audioPlayer.durationStream,
//         (position, bufferedPosition, duration) => PositionData(
//             position: position,
//             bufferedPosition: bufferedPosition,
//             duration: duration ?? Duration.zero),
//       );

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer()..setUrl(widget.item.audioUrl!);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _audioPlayer.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ItemTile(item: widget.item),
//             kDefaultVerticalSizedBox,
//             Text(
//               widget.item.title!,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
//             ),
//             kDefaultVerticalSizedBox,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 StreamBuilder<PlayerState>(
//                   stream: _audioPlayer.playerStateStream,
//                   builder: (context, snapshot) {
//                     final playerState = snapshot.data;
//                     final processingState = playerState?.processingState;
//                     final playing = playerState?.playing;
//                     if (!(playing ?? false)) {
//                       return ElevatedButton.icon(
//                           onPressed: _audioPlayer.play,
//                           icon: const Icon(Icons.play_circle_outline_rounded),
//                           label: const Text('Play'));
//                     } else if (processingState == ProcessingState.completed) {
//                       return const Text('not paused');
//                     }
//                     return ElevatedButton.icon(
//                         onPressed: _audioPlayer.pause,
//                         icon: const Icon(Icons.pause_circle_outline_rounded),
//                         label: const Text('Playing'));
//                   },
//                 ),
//                 CupertinoSlidingSegmentedControl(
//                   backgroundColor: kDarkColorScheme.surface,
//                   thumbColor:
//                       kDarkColorScheme.primaryContainer.withOpacity(0.5),
//                   children: {
//                     0: Text(
//                       'Script',
//                       style: TextStyle(
//                           color: kDarkColorScheme.onSecondaryContainer),
//                     ),
//                     1: Text(
//                       'Lesson',
//                       style: TextStyle(
//                           color: kDarkColorScheme.onSecondaryContainer),
//                     )
//                   },
//                   groupValue: selectedIndex,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   onValueChanged: (value) {
//                     setState(() {
//                       selectedIndex = value!;
//                     });
//                   },
//                 )
//               ],
//             ),
//             kDefaultVerticalSizedBox,
//             HtmlTextViewer(
//               text: widget.item.story,
//               fontSize: 18,
//               maxLine: 100,
//               normalColor: kDarkColorScheme.primary,
//               boldColor: kDarkColorScheme.primary,
//             ),
//             const Divider(
//               height: 20,
//             ),
//             HtmlTextViewer(
//               text:
//                   selectedIndex == 0 ? widget.item.script : widget.item.lesson,
//               fontSize: 22,
//               maxLine: 100,
//               normalColor: kDarkColorScheme.onSurface,
//               boldColor: kDarkColorScheme.primary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
