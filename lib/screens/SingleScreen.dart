import 'dart:core';

import 'package:aniflix/custom/AnimeBox.dart';
import 'package:aniflix/custom/EpisodeBox.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:aniflix/util/Episode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SingleScreenView.dart';

class SingleScreen extends StatelessWidget {
  final Anime anime;
  final List<Episode> episodes;

  const SingleScreen({Key? key, required this.anime, required this.episodes}) : super(key: key);

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
                children: getSingleBox(size.width, const EdgeInsets.all(8.0), 180.0),
              )
          ),
        ),
      ),
    );
  }

  List<Widget> getSingleBox(width, padding, height){
    List<Widget> childs = [];
    childs.add(AnimeBox(padding: padding, width: width, height: height, anime: anime));
    var i = 1;
    for(var episode in episodes){
      childs.add(EpisodeBox(padding: padding, width: width, height: 50.0, episode: episode, number: i,));
      i++;
    }
    return childs;
  }
}
