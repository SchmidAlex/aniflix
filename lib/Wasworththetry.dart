import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'util/Anime.dart';

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


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Anime>> futureAnimes;

  @override
  void initState() {
    super.initState();
    futureAnimes = fetchAnimes('1');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Stack(
          children: [
            Row(
              children: [
                Text("penis")
              ],
            ),
            Row(
              children: [
                Text("penis2")
              ],
            ),
          ],
        ),

        /*TODO:
          This works fine
        body: Column (children: <Widget>[
          Row(
            children: [Text("Test")],
          ),
          Row(
            children: [Text("data")],
          )
        ]
        ),*/

        /*body: Center (
          child: FutureBuilder<List<Anime>>(
            future: futureAnimes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for(var anime in snapshot.data!){
                  print(anime.cover_image);
                }

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),*/
      ),
    );
  }
}