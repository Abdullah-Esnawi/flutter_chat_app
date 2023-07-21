import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:video_player/video_player.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/play_video_icon.dart';

final isVideoPlaying = StateProvider.autoDispose((ref) => false);

class VideoPlayerItem extends ConsumerStatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  ConsumerState<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends ConsumerState<VideoPlayerItem> {
  late CachedVideoPlayerController _controller = CachedVideoPlayerController.network(widget.videoUrl);
  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        _controller.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(_controller),
          PlayVideoIcon(
              icon: Icons.play_arrow_rounded,
              onTap: () {
                Navigator.pushNamed(context, Routes.videoView, arguments: {'controller': _controller});
              })
        ],
      ),
    );
  }
}
////////////////////////////////////////////////////////////////
///
///
///
////////////////////////////////////////////////////////////////

class PlayingVideoView extends ConsumerStatefulWidget {
  final CachedVideoPlayerController _controller;
  const PlayingVideoView(this._controller, {super.key});

  @override
  ConsumerState<PlayingVideoView> createState() => _PlayingVideoViewState();
}

class _PlayingVideoViewState extends ConsumerState<PlayingVideoView> {
  @override
  void dispose() {
    super.dispose();
    widget._controller.pause();
    ref.read(isVideoPlaying.notifier).state = false;
  }

  String minutesString = '00';
  String secondsString = '00';

  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() {
      final duration = widget._controller.value.duration;
      final minutes = duration.inMinutes;
      final seconds = duration.inSeconds % 60;

      minutesString = '$minutes'.padLeft(2, '0');
      secondsString = '$seconds'.padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1011),
        elevation: 8,
      ),
      body: Container(
        color: AppColors.colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              color: AppColors.colors.black,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CachedVideoPlayer(widget._controller),
                  PlayVideoIcon(
                      size: 70,
                      icon: ref.watch(isVideoPlaying) ? Icons.pause : Icons.play_arrow_rounded,
                      onTap: () {
                        if (ref.watch(isVideoPlaying)) {
                          widget._controller.pause();
                          ref.read(isVideoPlaying.notifier).state = false;
                        } else {
                          widget._controller.play();
                          ref.read(isVideoPlaying.notifier).state = true;
                        }
                      })
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: AppColors.colors.black.withOpacity(.38),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ValueListenableBuilder<CachedVideoPlayerValue>(
                      valueListenable: widget._controller,
                      builder: (context, CachedVideoPlayerValue value, child) {
                        final minutes = value.position.inMinutes;
                        final seconds = value.position.inSeconds % 60;

                        final minutesString = '$minutes'.padLeft(2, '0');
                        final secondsString = '$seconds'.padLeft(2, '0');
                        return Text('$minutesString:$secondsString', style: TextStyle(color: AppColors.colors.white));
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: VideoProgressIndicator(
                        widget._controller,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          backgroundColor: AppColors.colors.neutral11,
                          playedColor: AppColors.colors.primary,
                          bufferedColor: AppColors.colors.neutral11,
                        ),
                      ),
                    ),
                    Text(
                      '$minutesString:$secondsString',
                      style: TextStyle(color: AppColors.colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



      // Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   SizedBox(
      //     height: MediaQuery.of(context).size.height * .5,
      //     // aspectRatio: 16 / 9,
      //     child: Stack(
      //       children: [
      //         CachedVideoPlayer(_controller),
      //         PlayVideoIcon(
      //             icon: ref.watch(isVideoPlaying) ? Icons.play_arrow : Icons.pause,
      //             onTap: () {
      //               print('here ...............');

      //               if (ref.watch(isVideoPlaying)) {
      //                 print('here one');
      //                 _controller.pause();
      //                 ref.read(isVideoPlaying.notifier).state = false;
      //               } else {
      //                 print('here two');
      //                 _controller.play();
      //                 ref.read(isVideoPlaying.notifier).state = true;
      //               }
      //             })
      //       ],
      //     ),
      //   ),
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Text('00:02'),
      //       VideoProgressIndicator(
      //         _controller,
      //         allowScrubbing: true,
      //         colors: VideoProgressColors(
      //           backgroundColor: AppColors.colors.white.withOpacity(.5),
      //           playedColor: AppColors.colors.primary,
      //         ),
      //       ),
      //       Text('00:53'),
      //     ],
      //   )
      // ]),