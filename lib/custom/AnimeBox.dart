import 'dart:html';

import 'package:aniflix/util/Anime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeBox extends StatelessWidget {

  final EdgeInsets padding;
  final double width, height;
  final Anime anime;

  const AnimeBox({Key? key, required this.padding, required this.width, required this.height, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: height,
          width: width,
          padding: padding,
          child: Row(
            children: [
              Expanded(child: printCover()),
              Expanded(child: printTitle()),
              Expanded(child: printDescription()),
            ],
          ),
        );
  }

  printDescription(){
    if(anime.descriptions.isNotEmpty){
      return Text(anime.descriptions, overflow: TextOverflow.ellipsis, maxLines: 2,);
    } else {
      return const Text("unfortunately there is no description", overflow: TextOverflow.ellipsis, maxLines: 2,);
    }
  }

  printTitle(){
    if(anime.title.isNotEmpty){
      return Text(anime.title + '\n\n\n\n');
    } else {
      return const Text("unfortunately there is no title");
    }
  }

  printCover(){
    if(anime.cover_image.isNotEmpty){
      return Image.network(anime.cover_image);
    } else {
      return const Text("unfortunately there is no picture");
    }
  }
}
