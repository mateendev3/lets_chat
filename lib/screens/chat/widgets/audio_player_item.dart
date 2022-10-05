import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerItem extends StatefulWidget {
  const AudioPlayerItem({
    Key? key,
    required this.audioUrl,
  }) : super(key: key);

  final String audioUrl;

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
