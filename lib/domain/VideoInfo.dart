import 'dart:async';
import 'dart:convert';

import 'package:movie_hero/domain/urls.dart' as urls;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<VideoInfo>> fetchVideoInfoList(String phrase) async {
  final response = await http.Client().get(urls.VIDEO_INFO_LIST + "/$phrase");
  return compute(parseVideoInfo, response.body);
}

List<VideoInfo> parseVideoInfo(String responseBody) {
  print(responseBody);
  return json.decode(responseBody).map<VideoInfo>((sub) => VideoInfo.fromJson(sub)).toList();
}

class VideoInfo {
  final String filmId;
  final List<String> lines;
  final int numSeq;

  VideoInfo({this.filmId, this.lines, this.numSeq});

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(filmId: json['filmId'], lines: json['lines'].cast<String>(), numSeq: json['numSeq']);
  }

  String linesAsString() {
    return lines.reduce((l1, l2) => l1 + "\n" + l2);
  }
}
