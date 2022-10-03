import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../utils/constants/colors_constants.dart';

class VideoPlayerItem extends ConsumerStatefulWidget {
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoPlayerItemState();
}

class _VideoPlayerItemState extends ConsumerState<VideoPlayerItem> {
  late final VideoPlayerController _videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _videoPlayerController.setVolume(1.0);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlaying) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              icon: isPlaying
                  ? const Opacity(
                      opacity: 0.6,
                      child: Icon(
                        Icons.pause_circle,
                        color: AppColors.white,
                        size: 36.0,
                      ),
                    )
                  : const Icon(
                      Icons.play_circle,
                      color: AppColors.white,
                      size: 36.0,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
