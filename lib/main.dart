import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

typedef void OnError(Exception exception);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration _duration = Duration();
  Duration _position = Duration();

  AudioPlayer advancePlayer;
  AudioCache audioCache;

  bool _playAudio = false;

  int index = 0;

  static const songs = [
    'Alan-Walker-Faded.mp3',
    'alone.mp3',
    'Hawa-Banke.mp3',
    'tu-hi-rab-48684-48719.mp3',
    'Senorita.mp3',
    'Maroon 5   Girls Like You .mp3',
    'Kesari Arijit Singh Ve Maahi .mp3',
    'Taqdeer Violin .mp3',
    'Game Of Thrones House Lannister .mp3',
    'Games Of Thrones   Violin.mp3'
  ];
  static const photos = [
    'assets/waker.jpeg',
    'assets/alan.jpeg',
    'assets/pexels-photo-1379636.jpeg',
    'assets/shelter.jpg',
    'assets/sanorita.jpeg',
    'assets/maroon5.jpeg',
    'assets/keshri.jpeg',
    'assets/below.jpg',
    'assets/lanister.jpeg',
    'assets/got.jpeg'
  ];

  @override
  void initState() {
    super.initState();

    initPlayer();

  }

  void initPlayer() {
    advancePlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancePlayer);

    advancePlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancePlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancePlayer.seek(newDuration);
  }

//  void playAndPause () {
//    print(_position.inSeconds.toDouble());
//    print(_duration.inSeconds.toDouble());
//    if(_playAudio == true) {
//      audioCache.play('alone.mp3');
//    } else {
//      advancePlayer.pause();
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('${photos[index]}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(5, 5),
                            blurRadius: 20,
                          )
                        ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      width: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        overflow: Overflow.clip,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      color: index == 0
                                          ? Colors.black26
                                          : Colors.black87,
                                      iconSize: 30,
                                      icon: Icon(Icons.fast_rewind),
                                      onPressed: () {
                                        setState(() {
                                          if (index > 0) {
                                            index--;
                                          } else {
                                            index = 0;
                                          }
                                          _playAudio = false;
                                          advancePlayer.stop();
                                          print(_playAudio);
                                          //    audioCache.play('alone.mp3');
                                        });
                                      },
                                    ),
                                    IconButton(
                                      color: index == songs.length - 1
                                          ? Colors.black26
                                          : Colors.black87,
                                      iconSize: 30,
                                      icon: Icon(Icons.fast_forward),
                                      onPressed: () {
                                        setState(() {
                                          if (index < songs.length - 1) {
                                            print(songs.length);
                                            print(index);
                                            index++;
                                          } else {
                                            index = 9;
                                            print(index);
                                          }
                                          _playAudio = false;
                                          print(_playAudio);
                                          advancePlayer.stop();
                                          //    advancePlayer.pause();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                elevation: 10,
                                onPressed: () {
                                  setState(() {
                                    _playAudio = !_playAudio;
                                    _playAudio == true
                                        ? audioCache.play('${songs[index]}')
                                        : advancePlayer.pause();
                                    //playAndPause();
                                    print(_playAudio);
                                  });
                                },
                                tooltip: 'play and pause',
                                child: Icon(
                                    _playAudio == true ?
                                    Icons.pause :
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${songs[index].trim()}",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        '${_position.inSeconds.toDouble()}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '${_duration.inSeconds.toDouble()}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    inactiveColor: Colors.black54,
                    onChanged: (double value) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
