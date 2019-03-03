import 'package:flutter/material.dart';
import 'package:movie_hero/widget/HeroVideoPlayer.dart';
import 'package:movie_hero/domain/VideoInfo.dart' as VideoInfo;

class SearchFragmentPage extends StatefulWidget {
  SearchFragmentPage({Key key}) : super(key: key);

  SearchFragmentPageState createState() => new SearchFragmentPageState();
}

class SearchFragmentPageState extends State<SearchFragmentPage> {
  List<VideoInfo.VideoInfo> videoInfoList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
            title: TextField(
              decoration: new InputDecoration(hintText: 'Search fragment by phrase'),
              onSubmitted: search,
            )),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new HeroVideoPlayer('http://192.168.1.73:8082/video/video?phrase=mother'),
            Column(children: [Text("Ola"), Text("Ola2s")])
          ],
        ),
      ),
    );
  }


  void search(phrase) {
    VideoInfo.fetchVideoInfoList(phrase).then((result) {
      videoInfoList = result;
      print(result);
    });
    print("finish ${phrase}");
  }

//  _renderBody() {
//    return FutureBuilder<List<Topics>>(
//        future: fetchTopics(http.Client()),
//        builder: (context, snapshot) {
//          if (snapshot.hasError) print(snapshot.error);
//
//          return snapshot.hasData
//              ? TopicsList(topics: snapshot.data)
//              : Center(child: CircularProgressIndicator());
//        }
//    );
//  }

//    setState(() {
//      _controller = VideoPlayerController.network('http://192.168.1.73:8082/video/video?phrase=${phrase}')
//        ..initialize();
//      _controller.setLooping(true);
//    });}
}
