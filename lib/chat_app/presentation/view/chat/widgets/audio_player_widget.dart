import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';

// final isAudioPlaying = StateProvider.autoDispose((ref) => false);

class AudioPlayerWidget extends ConsumerStatefulWidget {
  final String url;
  const AudioPlayerWidget({super.key, required this.url});

  @override
  ConsumerState<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? newTiming;

  bool isAudioPlaying = false;

  // bool isPlaying = false;

  void initAudio() {
    audioPlayer.play(UrlSource(widget.url));
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        newTiming = event;
      });
    });
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
    });
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                AppAssetImage(AppImages.defaultProfilePicture,
                    borderRadius: BorderRadius.circular(
                      30,
                    )),
                Positioned(
                  bottom: -3,
                  right: 0,
                  child: Icon(
                    Icons.mic,
                    color: AppColors.colors.neutral14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isAudioPlaying) {
                pauseAudio();
                setState(() {
                  isAudioPlaying = !isAudioPlaying;
                });
              } else {
                if (newTiming == null) {
                  initAudio();
                } else {
                  audioPlayer.resume();
                }
                setState(() {
                  isAudioPlaying = !isAudioPlaying;
                });
              }
            },
            child: Icon(
              isAudioPlaying ? Icons.pause : Icons.play_arrow_rounded,
              size: 40,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 35,
                  child: Slider(
                    value: newTiming == null ? 0 : newTiming!.inMilliseconds.toDouble(),
                    min: 0,
                    max: totalDuration == null ? 20 : totalDuration!.inMilliseconds.toDouble(),
                    activeColor: Colors.grey, //TODO: change to primary color if user seen message
                    inactiveColor: Colors.black38,
                    onChanged: (value) {
                      setState(() {
                        seekAudio(Duration(milliseconds: value.toInt()));
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
