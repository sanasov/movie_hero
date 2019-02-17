import 'package:movie_hero/page/SearchFragmentPage.dart';
import 'package:movie_hero/page/ProfilePage.dart';
import 'package:movie_hero/page/TrainingPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: SearchFragmentPage(),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: TrainingPage(),
            ),
          ),
          new Offstage(
            offstage: index != 2,
            child: TickerMode(
              enabled: index == 2,
              child: ProfilePage(),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
          },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text("Trainings")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile')
          )
        ])
    );
  }
}