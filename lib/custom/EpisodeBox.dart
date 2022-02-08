import 'package:aniflix/util/Episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpisodeBox extends StatelessWidget {

  final EdgeInsets padding;
  final double width, height;
  final Episode episode;
  final int number;

  const EpisodeBox({Key? key, required this.padding, required this.width, required this.height, required this.episode, required this.number}) : super(key: key);

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
                Expanded(child: Text('Episode ' + number.toString() + ': ' + episode.title)),
              ],
            ),
          ),
        onTap: (){
          Navigator.pushNamed(context, '/video', arguments: {'episode': episode});
        },
      );
  }
}
