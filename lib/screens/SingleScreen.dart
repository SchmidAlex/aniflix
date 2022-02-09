import 'dart:core';

import 'package:aniflix/custom/AnimeBox.dart';
import 'package:aniflix/custom/EpisodeBox.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:aniflix/util/Episode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SingleScreen extends StatelessWidget {
  final Anime anime;
  late Future<List<Episode>> futureEpisode = fetchEpisodes();

  SingleScreen({Key? key, required this.anime,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<Episode> episodes = List.empty(growable: true);
    final Size size = MediaQuery.of(context).size;

    return
      FutureBuilder<List<Episode>>(
        future: futureEpisode,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for(var single in snapshot.data!){
              episodes.add(single);
            }
            return
              SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: anime.printTitle(),
                  ),
                  body: Column(
                    children: [
                      AnimeBox(padding: const EdgeInsets.all(8.0), width: size.width, height: 180.0, anime: anime),
                      Expanded(
                        child: ListView.builder(
                          itemCount: episodes.length,
                          itemBuilder: (buildContext, index) {
                            return
                              InkWell(
                                child:
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListTile(
                                      title: Text(episodes[index].title),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, '/video', arguments: {'videourl': episodes[index].video});
                                },
                              );
                          }
                        )
                      ),
                    ],
                  )
                )
              );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error} + Snapshot SingleScreen');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
  }

  Future<List<Episode>> fetchEpisodes() async {
    final response = await http
        .get(Uri.parse('https://api.aniapi.com/v1/episode?anilist_id=' + anime.anilist_id.toString()));

    if (response.statusCode == 200) {
      return getEpisodesFromJson(response.body);
    } else {
      throw Exception('Failed to load Animes');
    }
  }
}
