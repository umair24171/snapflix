import 'package:snapflix/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleReel extends StatefulWidget {
  SingleReel({super.key, required this.postModel});
  PostModel postModel;
  @override
  State<SingleReel> createState() => _SingleReelState();
}

class _SingleReelState extends State<SingleReel> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.postModel.imageUrl))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized
            setState(() {});
          });

    _videoPlayerController.setVolume(1);
    _videoPlayerController.seekTo(const Duration(seconds: 0));
  }

  @override
  void dispose() {
    // Ensure you dispose of the video controller when the widget is disposed
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: GestureDetector(
            onTap: () {
              if (_videoPlayerController.value.isPlaying) {
                _videoPlayerController.pause();
              } else {
                _videoPlayerController.play();
              }
            },
            child: VideoPlayer(_videoPlayerController)));
  }
}
