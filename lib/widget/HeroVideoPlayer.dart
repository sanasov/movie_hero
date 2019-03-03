import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HeroVideoPlayer extends StatefulWidget {
  final String url;

  HeroVideoPlayer(this.url);

  VideoPlayerState createState() => new VideoPlayerState(url);
}

class VideoPlayerState extends State<HeroVideoPlayer> {
  VideoPlayerController _controller;
  bool isFinish = false;
  bool autoPlay = true;
  num playCount = 0;
  final String _url;

  VideoPlayerState(this._url);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(_url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..addListener(playerListeners);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(alignment: AlignmentDirectional.center, children: [
      Container(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      isFinish
          ? Align(
              child: IconButton(
              icon: Icon(Icons.play_circle_outline),
              tooltip: 'Increase volume by 10%',
              onPressed: () => replay(),
              iconSize: 96,
            ))
          : Container()
    ]);
  }

  replay() {
    print("pressed replay");
    setState(() {
      _controller.seekTo(Duration());
      isFinish = false;
    });
  }

  playerListeners() {
    isFinishListener();
    autoplayListener();
  }

  isFinishListener() {
    if (_controller.value.duration.inMilliseconds <= _controller.value.position.inMilliseconds && !isFinish) {
      setState(() {
        isFinish = true;
        playCount++;
      });
    }
  }

  autoplayListener() {
    if (autoPlay && !_controller.value.isPlaying && playCount == 0) {
      setState(() {
        _controller.play();
      });
    }
  }
}