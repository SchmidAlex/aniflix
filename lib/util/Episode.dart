import 'dart:convert';


class Episode {
  late String title;
  late String video;

  Episode(this.title, this.video);

}


getEpisodesFromJson(dynamic jsonString){

  var json = jsonDecode(jsonString);

  List<Episode> episodes = List.empty(growable: true);

  for(var singleEpisode in json['data']['documents']){
    if (singleEpisode['locale'] == 'en' && !singleEpisode['source'].contains('dub')){
      episodes.add(Episode(singleEpisode['title'], singleEpisode['video']));
    }
  }
  return episodes;
}