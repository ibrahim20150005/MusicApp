import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import 'MyList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final FlutterAudioQuery audioQuery = new FlutterAudioQuery();
final AudioPlayer audioPlayer = new AudioPlayer();
List<SongInfo> songs = [];

Color getColor() {
  return Colors.grey[700];
}

class _MyAppState extends State<MyApp> {
  void getTrack() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  @override
  void initState() {
    super.initState();
    getTrack();
  }

  void dispose() {
    super.dispose();
    audioPlayer?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.yellowAccent,
        accentColor: Colors.white,

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyList(),
    );
  }
}
