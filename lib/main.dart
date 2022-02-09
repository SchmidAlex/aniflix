import 'dart:ui';
import 'package:aniflix/screens/LandingScreen.dart';
import 'package:aniflix/screens/SingleScreen.dart';
import 'package:aniflix/screens/VideoScreen.dart';
import 'package:aniflix/util/AnimeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'util/constants.dart';

void main() {
  final animes = Animes();
  animes.initData();
  runApp(MyApp(animes: animes,));
}

class MyApp extends StatelessWidget {
  final Animes animes;
  const MyApp({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double screenWidth = window.physicalSize.width;

    return ChangeNotifierProvider<Animes>(
        create: (_) => animes,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aniflix',
          theme: ThemeData(primaryColor: COLOR_BLACK, accentColor: COLOR_DARK_BLUE, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT),
          initialRoute: '/',
          routes: {
            //Maybe a dynamic url with {page} or something like that
            '/': (context) => const LandingScreen(),
            '/singlescreen': (context) => SingleScreen(anime: (ModalRoute.of(context)!.settings.arguments as Map)['anime'],),
            '/video': (context) => VideoScreen(videoUrl: (ModalRoute.of(context)!.settings.arguments as Map)['videourl'],),
          },
        ),
    );
  }
}

