import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class StatusView extends StatefulWidget {
  const StatusView({super.key, required this.status});
  final StatusEntity status;

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  final _controller = StoryController();
  List<StoryItem> stories = [];
  @override
  void initState() {
    super.initState();
    initStories();
  }

  void initStories() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      stories.add(StoryItem.pageImage(url: widget.status.photoUrl[i], controller: _controller, caption: widget.status.caption));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stories.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: stories,
              controller: _controller,
              onVerticalSwipeComplete: (dir) {
                if(dir == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ),
    );
  }
}
