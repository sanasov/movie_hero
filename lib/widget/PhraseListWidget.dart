import 'package:flutter/material.dart';
import 'package:movie_hero/domain/VideoInfo.dart' as VideoInfo;

class PhraseListWidget extends StatelessWidget {
  final List<VideoInfo.VideoInfo> videoInfoList;
  final num currentNumber;

  PhraseListWidget(this.videoInfoList, this.currentNumber);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: videoInfoList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return index != currentNumber
              ? new Text("${index + 1}.\t" + videoInfoList[index].linesAsString())
              : new Text("${index + 1}.\t" + videoInfoList[index].linesAsString(), style: TextStyle(fontWeight: FontWeight.bold));
        });
  }
}
