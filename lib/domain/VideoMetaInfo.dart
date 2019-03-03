import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<VideoInfo>> fetchVideoInfoList(http.Client client, String phrase) async {
  final response = await client.get("/$phrase");

  return compute(parseVideoInfo, response.body);
}

List<VideoInfo> parseVideoInfo(String responseBody) {
  final parsed = json.decode(responseBody)['data']['children'].cast<Map<String, dynamic>>();
  return parsed.map<VideoInfo>((json) => VideoInfo.fromJson(json['data'])).toList();
}

class VideoInfo {
  final String title;
  final String subtitle;
  final String url;

  VideoInfo({this.title, this.subtitle, this.url});

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(title: json['title'], subtitle: json['subtitle'], url: json['url']);
  }
}
