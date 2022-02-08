import 'dart:ui';
import 'package:aniflix/screens/LandingScreen.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Anime>> fetchAnimes(String page, int apiPagination) async {
  final response = await http
      .get(Uri.parse('https://api.aniapi.com/v1/anime?page=' + page));

  if (response.statusCode == 200) {
    return getAnimesFromJson(response.body, apiPagination);
  } else {
    throw Exception('Failed to load Animes');
  }
}

class FetchAnimesAndReturnLandingScreen extends StatefulWidget {
  final int fetchPage;

  const FetchAnimesAndReturnLandingScreen({Key? key, required this.fetchPage}) : super(key: key);

  @override
  FetchAnimesAndReturnLandingScreenState createState() => FetchAnimesAndReturnLandingScreenState();
}

class FetchAnimesAndReturnLandingScreenState extends State<FetchAnimesAndReturnLandingScreen> {

  late Future<List<Anime>> futureAnimes = (fetchAnimes(widget.fetchPage.toString(), apiPagePagination));
  final List<Anime> animes = [];
  int apiPagePagination = 1;
  int apiMaxPagePagination = 10;

  void initApiMaxPagePagination(int maxPage){
    apiMaxPagePagination = maxPage;
  }

  void incrementPage(){
    if(apiPagePagination < apiMaxPagePagination){
      setState(() {
        apiMaxPagePagination++;
      });
    }
  }
  void decrementPage(){
    if(apiPagePagination > 1){
      setState(() {
        apiPagePagination--;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Anime>>(
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
        return const SizedBox(
          height: 100, width: 100,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

