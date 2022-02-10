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
  late Animes animeData;


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
          centerTitle: true,
            actions: <Widget>[
              Padding(
              padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    //TODO: somehow a textfield and search it
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
            ]
        ),
        body: Column(
          children: [
            const Expanded(child: AnimeList(),),
            SizedBox(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: animeData.previousData, icon: const Icon(Icons.arrow_back_sharp), tooltip: 'Previous Page', alignment: Alignment.centerLeft,),
                  IconButton(onPressed: animeData.nextData, icon: const Icon(Icons.arrow_forward_sharp), tooltip: 'Next Page', alignment: Alignment.centerRight,),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  randomAnime() {
    Navigator.pushNamed(context, '/singlescreen', arguments: {'anime': animeData.getRandomAnime()});
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
                                padding: const EdgeInsets.all(10.0),
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
