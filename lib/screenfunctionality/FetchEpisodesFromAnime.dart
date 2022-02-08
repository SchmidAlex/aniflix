import 'dart:core';

import 'package:aniflix/screens/SingleScreen.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:aniflix/util/Episode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchEpisodesFromAnime extends StatelessWidget {
  final Anime anime;

  const FetchEpisodesFromAnime({required this.anime});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    late Future<List<Episode>> futureEpisodes = (fetchEpisodes());
    List<Episode> episodes = [];

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: FutureBuilder<List<Episode>>(
              future: futureEpisodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (var episode in snapshot.data!) {
                    episodes.add(episode);
                  }
                  return SingleScreen(episodes: episodes, anime: anime,);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }
          ),
        ),
      ),
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
