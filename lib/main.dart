import 'dart:ui';
import 'package:aniflix/screenfunctionality/FetchAnimesAndReturnLandingScreen.dart';
import 'package:aniflix/screenfunctionality/FetchEpisodesFromAnime.dart';
import 'package:aniflix/screens/VideoScreen.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:flutter/material.dart';
import 'util/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Future<List<Anime>> futureAnimes = (fetchAnimes("1"));
  List<Anime> animes = [];


  @override
  Widget build(BuildContext context){
    double screenWidth = window.physicalSize.width;
    Anime animeArg = Anime(0, 'Error', 'There went something wrong with the router argument', 'cover_image', List.generate(3, (index) => "null"), 3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aniflix',
      theme: ThemeData(primaryColor: COLOR_BLACK, accentColor: COLOR_DARK_BLUE, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
      initialRoute: '/',
      routes: {
        //Maybe a dynamic url with {page} or something like that
        '/': (context) => FetchAnimesAndReturnLandingScreen(),
        '/singlescreen': (context) => FetchEpisodesFromAnime(anime: (ModalRoute.of(context)!.settings.arguments as Map)['anime'],),
        //'/video': (context) => VideoScreen(episode: (ModalRoute.of(context)!.settings.arguments as Map)['episode'],),
      },
    );
  }
}

