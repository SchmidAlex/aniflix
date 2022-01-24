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


getAnimesFromJson(dynamic jsonString){

  var test = jsonDecode(jsonString);

  List<Anime> animes = List.empty(growable: true);

  for(var singleAnime in test['data']['documents']){

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
  return animes;
}

checkForNull(dynamic checkValue){
  if(["", null, false, 0].contains(checkValue)){
    return "null";
  } else {
    return checkValue;
  }
}