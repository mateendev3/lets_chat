import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../../../models/status.dart';
import '../../../utils/common/widgets/loader.dart';

class WatchStatusScreen extends StatefulWidget {
  const WatchStatusScreen({required this.status, super.key});
  final Status status;

  @override
  State<WatchStatusScreen> createState() => _WatchStatusScreenState();
}

class _WatchStatusScreenState extends State<WatchStatusScreen> {
  late final StoryController _storyController;
  final List<StoryItem> _storyItems = [];

  @override
  void initState() {
    super.initState();
    _storyController = StoryController();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (var photoUrl in widget.status.photoUrls) {
      _storyItems.add(
        StoryItem.pageImage(
          url: photoUrl,
          controller: _storyController,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _storyItems.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: _storyItems,
              controller: _storyController,
              onVerticalSwipeComplete: _onVerticalSwipeComplete,
            ),
    );
  }

  _onVerticalSwipeComplete(Direction? direction) {
    if (direction == Direction.down) {
      Navigator.pop(context);
    }
  }
}
