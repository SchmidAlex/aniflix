import 'dart:core';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({Key? key, required this.videoUrl,}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

}

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
          child: Scaffold(
              body: Container(
                child: Text('Videoscreen' + videoUrl),
              )
          )
      );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
