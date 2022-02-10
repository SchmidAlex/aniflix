import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';


class Anime {
  late int id;
  late String title;
  late String descriptions;
  late String cover_image;
  late List<String> genres;
  late int score;

  Anime(this.id, this.title, this.descriptions, this.cover_image,
      this.genres, this.score);


  printCover(){
    if(cover_image.contains('null')){
      return const Text("unfortunately there is no picture");
    } else {
      return Image.network(cover_image,);
    }
  }

  printTitle(){
    if(title.contains('null')){
      return const Text('Unfortunately there is no anime title \n');
    } else {
      return Text(title + '\n');
    }
  }

  printDescription(){
    if(descriptions.contains('null')){
      return const Text('Unfortunately there is no anime description \n\n');
    } else {
      return Text(descriptions + '\n\n', overflow: TextOverflow.fade, maxLines: 5,);
    }
  }
}


getAnimesFromJson(dynamic jsonString){

  var data = jsonDecode(jsonString);

  List<Anime> animes = List.empty(growable: true);


  for(var singleAnime in data['data']['documents']){
      List<String> genres = List.empty(growable: true);

      singleAnime['genres'].forEach((v) => genres.add(checkForNull(v)));

      animes.add(Anime(
          checkForNull(singleAnime['id']),
          checkForNull(singleAnime['titles']['en']),
          checkForNull(singleAnime['descriptions']['en']),
          checkForNull(singleAnime['cover_image']),
          genres,
          checkForNull(singleAnime['score'])
      ));
  }
  return animes;
}

checkForNull(dynamic checkValue){
  if(["", null, false, 0].contains(checkValue)){
    return "null";
  } else {
    return checkValue;
  }
}