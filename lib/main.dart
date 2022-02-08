import 'dart:ui';
import 'package:aniflix/screenfunctionality/FetchAnimesAndReturnLandingScreen.dart';
import 'package:aniflix/screenfunctionality/FetchEpisodesFromAnime.dart';
import 'package:flutter/material.dart';
import 'util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int actPagIdx = 2;
  int maxPage = 1;

  void initMaxPage(int maxPage){
    this.maxPage = maxPage;
  }

  void incrementPage(){
    if(actPagIdx < maxPage){
      setState(() {
        actPagIdx++;
      });
    }
  }
  void decrementPage(){
    if(actPagIdx > 1){
      setState(() {
        actPagIdx--;
      });
    }
  }
  @override
  Widget build(BuildContext context){
    double screenWidth = window.physicalSize.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aniflix',
      theme: ThemeData(primaryColor: COLOR_BLACK, accentColor: COLOR_DARK_BLUE, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
      initialRoute: '/',
      routes: {
        //Maybe a dynamic url with {page} or something like that
        '/': (context) => FetchAnimesAndReturnLandingScreen(fetchPage: actPagIdx,),
        '/singlescreen': (context) => FetchEpisodesFromAnime(anime: (ModalRoute.of(context)!.settings.arguments as Map)['anime'],),
        //'/video': (context) => VideoScreen(episode: (ModalRoute.of(context)!.settings.arguments as Map)['episode'],),
      },
    );
  }
}

