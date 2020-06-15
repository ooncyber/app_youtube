import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: Inicio(),
    ),
  );
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String _sharedText;
  StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        print(value);
        _sharedText = value.substring(value.indexOf('be/') + 3, value.length);
        print(value);
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  var _apikey = 'AIzaSyAEyqYdAdjUAo9hBHUoegu04HOb033_Eis';

  var _controller = YoutubePlayerController(
    initialVideoId: 'G6xEpd3NRPM',
    flags: YoutubePlayerFlags(
      mute: false,
      autoPlay: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista YOUTUBE'),
        ),
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return Column(
              children: <Widget>[player],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          _controller.load('Lmh-LZ_RJ3Y');
        }));
  }
}
