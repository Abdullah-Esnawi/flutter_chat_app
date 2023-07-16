import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
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
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(_controller),
          IconButton(
            icon: Icon(Icons.play_circle),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
