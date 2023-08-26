import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/audio_helper.dart';

class CustomPlayButton extends StatelessWidget {
  const CustomPlayButton({
    super.key,
    required AudioHelper audioPlayer,
    required this.isShorten,
  }) : _audioPlayer = audioPlayer;

  final AudioHelper _audioPlayer;
  final bool isShorten;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _audioPlayer.buttonNotifier,
      builder: (context, value, child) {
        switch (value) {
          case ButtonState.loading:
            return const Center(child: CircularProgressIndicator());
          case ButtonState.paused:
            return isShorten
                ? IconButton(
                    onPressed: () => _audioPlayer.play(),
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                    ))
                : ElevatedButton.icon(
                    onPressed: _audioPlayer.play,
                    icon: const Icon(
                      Icons.play_circle_outline_rounded,
                      size: 30,
                    ),
                    label: const Text('Play'));
          case ButtonState.playing:
            return isShorten
                ? IconButton(
                    onPressed: () => _audioPlayer.pause(),
                    icon: const Icon(
                      Icons.pause,
                      size: 30,
                    ))
                : ElevatedButton.icon(
                    onPressed: _audioPlayer.pause,
                    icon: SizedBox(
                        height: 40,
                        width: 40,
                        child: Lottie.asset('assets/lottie/playing.json')),
                    label: const Text('Playing'),
                  );
        }
      },
    );
  }
}
