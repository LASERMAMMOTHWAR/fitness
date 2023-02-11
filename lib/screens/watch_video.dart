import 'package:flutter/material.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import '../utilities/constants.dart';




class Video_Player extends StatefulWidget {
  const Video_Player({Key? key}) : super(key: key);

  @override
  State<Video_Player> createState() => _Video_PlayerState();
}

class _Video_PlayerState extends State<Video_Player> {

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'iSgly1eGHvM',// https://www.youtube.com/watch?v=Tb9k9_Bo-G4
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
      builder: (context, player) {
        return Container(
          child: player,
        );
        // return Consumer<ModelTheme>(
        //   builder: (context, ModelTheme themeNotifier, child) {
        //     return Container(
        //       padding: const EdgeInsets.all(20.0),
        //       decoration: BoxDecoration(
        //         color: themeNotifier.isDark ? Colors.grey[800]: Colors.grey[900],
        //         borderRadius: BorderRadius.only(
        //           topRight: Radius.circular(20.0),
        //           topLeft: Radius.circular(20.0),
        //         ),
        //       ),
        //       child: player,
        //     );
        //   }
        // );
      },
    );
  }
}












