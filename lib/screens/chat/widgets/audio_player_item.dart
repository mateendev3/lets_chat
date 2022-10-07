import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors_constants.dart';

class AudioPlayerItem extends StatefulWidget {
  const AudioPlayerItem({
    Key? key,
    required this.audioUrl,
    required this.isSender,
  }) : super(key: key);

  final String audioUrl;
  final bool isSender;

  @override
  State<AudioPlayerItem> createState() => _AudioPlayerItemState();
}

class _AudioPlayerItemState extends State<AudioPlayerItem> {
  late final AudioPlayer _audioPlayer;
  bool _isPlayingAudio = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 36.0,
      color: widget.isSender ? AppColors.white : AppColors.primary,
      constraints: const BoxConstraints(minWidth: 100.0),
      onPressed: () {
        if (!_isPlayingAudio) {
          _audioPlayer.play(UrlSource(widget.audioUrl));
        } else {
          _audioPlayer.pause();
        }

        setState(() => _isPlayingAudio = !_isPlayingAudio);
      },
      icon: Icon(_isPlayingAudio ? Icons.pause_circle : Icons.play_circle),
    );
  }
}
