import 'package:flutter/material.dart';
import 'package:movie_hero/domain/VideoInfo.dart';
import 'package:movie_hero/domain/urls.dart' as urls;
import 'package:movie_hero/widget/PhraseListWidget.dart';
import 'package:video_player/video_player.dart';

class HeroVideoPlayer extends StatefulWidget {
  final List<VideoInfo> videoInfoList;

  HeroVideoPlayer(this.videoInfoList);

  VideoPlayerState createState() => new VideoPlayerState(videoInfoList);
}

class VideoPlayerState extends State<HeroVideoPlayer> {
  VideoPlayerController _controller;
  bool isFinish = false;
  bool autoPlay = true;
  num playCount = 0;
  num currentVideoIndex = 0;
  List<VideoInfo> _videoInfoList;

  VideoPlayerState(this._videoInfoList);

  @override
  void initState() {
    print(urls.VIDEO + "/${_videoInfoList[currentVideoIndex].filmId}/${_videoInfoList[currentVideoIndex].numSeq}");
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //  crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _renderPlayer(),
        Container(
            child: new PhraseListWidget(this._videoInfoList, this.currentVideoIndex),
            width: 200) //Container(child:, height: 100, width: 200)
      ],
    );
  }

  Widget _renderPlayer() {
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
        currentVideoIndex++;
        initVideo();
      });
    }
  }

  initVideo() {
    _controller = VideoPlayerController.network(
        urls.VIDEO + "/${_videoInfoList[currentVideoIndex].filmId}/${_videoInfoList[currentVideoIndex].numSeq}")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..addListener(playerListeners);
  }

  autoplayListener() {
    if (autoPlay && !_controller.value.isPlaying && playCount == 0) {
      setState(() {
        _controller.play();
      });
    }
  }
}
