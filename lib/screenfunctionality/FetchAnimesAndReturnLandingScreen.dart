import 'dart:ui';
import 'package:aniflix/screens/LandingScreen.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Anime>> fetchAnimes(String page) async {
  final response = await http
      .get(Uri.parse('https://api.aniapi.com/v1/anime?page=' + page));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return getAnimesFromJson(response.body);

    //return Anime.getAnimesFromJson(response.body);
    //return Anime.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Animes');
  }
}

class FetchAnimesAndReturnLandingScreen extends StatelessWidget {
  late Future<List<Anime>> futureAnimes = (fetchAnimes("1"));
  final List<Anime> animes = [];

  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List<Anime>>(
        future: futureAnimes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for(var anime in snapshot.data!){
              animes.add(anime);
            }
            return LandingScreen(animes: animes,);

          } else if (snapshot.hasError) {
            return Text('${snapshot.error} -> Snapshot error');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
