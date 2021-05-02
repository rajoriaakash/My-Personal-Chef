import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {
  final String url;

  const Player({Key key, this.url}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  YoutubePlayerController _controller;
  void run(){
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      flags: YoutubePlayerFlags(
        mute: false,
        isLive: false,
        enableCaption: true,
        autoPlay: false,
        controlsVisibleAtStart: true,
      )
    );
  }

  @override
  void initState() {
    run();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: ProgressBarColors(
          backgroundColor: Colors.white,
          playedColor: Colors.red,
          bufferedColor: Colors.black.withOpacity(0.2),
        ) ,
      ),
      builder: (context, player) {
        return Card(
          child: player,
        );
      },
    );
  }
}
