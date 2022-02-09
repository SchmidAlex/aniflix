import 'dart:core';
import 'package:aniflix/util/AnimeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class LandingScreen extends StatefulWidget{
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  ShakeDetector? _detector;
  Animes? animeData;

  @override
  initState() {
    super.initState();
    _detector = ShakeDetector.autoStart(onPhoneShake: randomAnime);
  }

  @override
  Widget build(BuildContext context) {
    animeData = Provider.of<Animes>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Animes'),
        ),
        body: Column(
          children: const [
            Expanded(child: AnimeList(),),
            //TODO: Pagination buttons
          ],
        ),
      ),
    );
  }

  randomAnime() {
    Navigator.pushNamed(context, '/singlescreen', arguments: {'anime': animeData?.getRandomAnime()});
  }

  @override
  dispose() {
    _detector?.stopListening();
    super.dispose();
  }
}

class AnimeList extends StatelessWidget{
  const AnimeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animes animes = Provider.of<Animes>(context);
    return FutureBuilder(
      future: animes.initData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return
              ListView.builder(
                itemCount: animes.animes.length,
                itemBuilder: (buildContext, index) {
                  return
                    InkWell(
                      child:
                        Card(
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: ListTile(
                                    horizontalTitleGap: 50.0,
                                    leading: animes.animes[index].printCover(),
                                    title: animes.animes[index].printTitle(),
                                    subtitle: animes.animes[index].printDescription(),
                                ),
                            ),
                        ),
                      onTap: (){
                        Navigator.pushNamed(context, '/singlescreen', arguments: {'anime': animes.animes[index]});
                      },
                    );
                },
              );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error} + Snapshot LandingScreenError');
          }
          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

}
