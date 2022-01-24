import 'dart:core';

import 'package:aniflix/custom/AnimeBox.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  final List<Anime> animes;

  const LandingScreen({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: (
            ListView(
              children: getAnimeList(size.width),
            )
          ),
        ),
      ),
    );
  }

  List<Widget> getAnimeList(width){
    List<Widget> childs = [];
    for(var anime in animes){
      childs.add(AnimeBox(padding: const EdgeInsets.all(8.0), width: width, height: 180.0, anime: anime,));
    }
    return childs;
  }
}
