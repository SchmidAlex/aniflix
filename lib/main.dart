import 'dart:ui';
import 'package:aniflix/screenfunctionality/FetchAnimesAndReturnLandingScreen.dart';
import 'package:aniflix/screenfunctionality/FetchEpisodesFromAnime.dart';
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

    final Anime arguments = Anime(10, 'Test', 'descriptions', 'cover_image', List.generate(3, (index) => "null"), 3);
    //final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aniflix',
      theme: ThemeData(primaryColor: COLOR_BLACK, accentColor: COLOR_DARK_BLUE, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
      initialRoute: '/',
      routes: {
        '/': (context) => FetchAnimesAndReturnLandingScreen(),
        '/singlescreen': (context) => FetchEpisodesFromAnime(anime: arguments,),
      },
    );
  }
}

