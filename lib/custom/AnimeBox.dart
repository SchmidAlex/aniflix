import 'package:aniflix/screens/SingleScreen.dart';
import 'package:aniflix/util/Anime.dart';
import 'package:flutter/material.dart';

class AnimeBox extends StatelessWidget {

  final EdgeInsets padding;
  final double width, height;
  final Anime anime;

  const AnimeBox({Key? key, required this.padding, required this.width, required this.height, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        child:
          Container(
            height: height,
            width: width,
            padding: padding,

            child: Row(
              children: [
                Expanded(child: printCover()),
                Expanded(child: printInformation()),
              ],
            ),
          ),
        onTap: (){
          Navigator.pushNamed(context, '/singlescreen', arguments: {'anime': anime});
        },
      );
  }

  printCover(){
    if(anime.cover_image.contains('null')){
      return const Text("unfortunately there is no picture");
    } else {
      return Image.network(anime.cover_image);
    }
  }

  printInformation(){
    var information = '';
    if(anime.title.contains('null')){
      information += 'Unfortunately there is no anime title \n\n';
    } else {
      information += anime.title + '\n\n';
    }
    if(anime.descriptions.contains('null')){
      information += 'Unfortunately there is no description \n\n';
    } else {
      information += anime.descriptions;
    }
    return Text(information);
  }
}
