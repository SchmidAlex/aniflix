import 'dart:convert';

import 'package:flutter/material.dart';


class Anime {
  late int anilist_id;
  late String title;
  late String descriptions;
  late String cover_image;
  late List<String> genres;
  late int score;

  Anime(this.anilist_id, this.title, this.descriptions, this.cover_image,
      this.genres, this.score);

  printOverview(){

  }

  printSingleView(){

  }
}


getAnimesFromJson(dynamic jsonString){

  var test = jsonDecode(jsonString);

  List<Anime> animes = List.empty(growable: true);

  for(var singleAnime in test['data']['documents']){

    List<String> genres = List.empty(growable: true);

    singleAnime['genres'].forEach((v) => genres.add(v));

    animes.add(Anime(
      singleAnime['anilist_id'],
      singleAnime['titles']['en'],
      singleAnime['descriptions']['en'],
      singleAnime['cover_image'],
      genres,
      singleAnime['score']
    ));
  }
  return animes;
}