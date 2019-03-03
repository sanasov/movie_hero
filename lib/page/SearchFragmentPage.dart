import 'package:flutter/material.dart';
import 'package:movie_hero/widget/HeroVideoPlayer.dart';
import 'package:http/http.dart' as http;

class SearchFragmentPage extends StatefulWidget {
  SearchFragmentPage({Key key}) : super(key: key);

  SearchFragmentPageState createState() => new SearchFragmentPageState();
}

class SearchFragmentPageState extends State<SearchFragmentPage> {

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
    print("finish ${phrase}");
    http.Client().get('http://192.168.1.73:8082/video/subtitle?phrase=${phrase}');
//    setState(() {
//      _controller = VideoPlayerController.network('http://192.168.1.73:8082/video/video?phrase=${phrase}')
//        ..initialize();
//      _controller.setLooping(true);
//    });
  }
}
