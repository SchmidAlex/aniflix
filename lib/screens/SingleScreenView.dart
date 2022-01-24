import 'dart:core';

import 'package:aniflix/custom/EpisodeBox.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:aniflix/util/Episode.dart';
import 'package:flutter/material.dart';

class SingleScreenView extends StatelessWidget {
  final List<Episode> episodes;
  final Anime anime;

  const SingleScreenView({Key? key, required this.episodes, required this.anime}) : super(key: key);

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
                children: getEpisodeList(size.width),
              )
          ),
        ),
      ),
    );
  }

  List<Widget> getEpisodeList(width){
    List<Widget> childs = [];
    int i = 0;
    for(var episode in episodes){
      childs.add(EpisodeBox(padding: const EdgeInsets.all(8.0), width: width, height: 100.0, episode: episode, number: i,));
      i++;
    }
    return childs;
  }
}
