import 'package:alga/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideo extends StatelessWidget {
  final String videoUrl;
  late final YoutubePlayerController _videoController;

  YoutubeVideo({required this.videoUrl}) {
    _videoController = YoutubePlayerController(
      initialVideoId: Helper.convertUrlToId(videoUrl),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _videoController,
      aspectRatio: 16 / 9,
    );
  }
}
