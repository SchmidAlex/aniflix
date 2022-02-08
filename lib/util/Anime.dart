import 'dart:convert';


class Anime {
  late int anilist_id;
  late String title;
  late String descriptions;
  late String cover_image;
  late List<String> genres;
  late int score;

  Anime(this.anilist_id, this.title, this.descriptions, this.cover_image,
      this.genres, this.score);

}


getAnimesFromJson(dynamic jsonString, int apiPagination){

  var data = jsonDecode(jsonString);
  int counter = 1;

  List<Anime> animes = List.empty(growable: true);

  //TODO: set the max page in main


  //TODO: set the max page in fetchanimesandreturnlandingscreen


  for(var singleAnime in data['data']['documents']){
    if(counter / 10 + 1 >= apiPagination && animes.length < 10){
      List<String> genres = List.empty(growable: true);

      singleAnime['genres'].forEach((v) => genres.add(checkForNull(v)));

      animes.add(Anime(
          checkForNull(singleAnime['anilist_id']),
          checkForNull(singleAnime['titles']['en']),
          checkForNull(singleAnime['descriptions']['en']),
          checkForNull(singleAnime['cover_image']),
          genres,
          checkForNull(singleAnime['score'])
      ));
    }
    counter++;
    if(animes.length > 9){
      break;
    }
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