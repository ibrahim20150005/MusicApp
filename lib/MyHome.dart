import 'package:flutter/material.dart';
import 'dart:io';
import 'main.dart';

// ignore: must_be_immutable
class MyHome extends StatefulWidget {
  int index;

  MyHome(this.index);

  @override
  _MyHomeState createState() => _MyHomeState(index);
}

bool playMusic;
IconData bt = Icons.play_arrow;
double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
String currentTime = '', endTime = '';
var currIndex = -1;

class _MyHomeState extends State<MyHome> {
  int index;

  final _key = GlobalKey();

  _MyHomeState(this.index);

  void initState() {
    super.initState();
    playMusic = true;
    // currIndex = index;
    changeState(index);
  }

  changeState(int index) async {
    if (playMusic == true) {
      print('------------------');
      print(songs[index].displayName);
      print('------------------');
      bt = Icons.pause_circle_filled_rounded;
      playMusic = false;
      if (currIndex != index) {
        await audioPlayer.setUrl(songs[index].uri);
      }
      currIndex = -1;
      minimumValue = 0.0;
      currentValue = minimumValue;
      maximumValue = audioPlayer.duration.inMilliseconds.toDouble();
      //   endTime = getDuration(maximumValue);
      setState(() {
        currentTime = getDuration(currentValue);
        endTime = getDuration(maximumValue);
      });

      audioPlayer.play();
      audioPlayer.positionStream.listen((duration) {
        currentValue = duration.inMilliseconds.toDouble();
        setState(() {
          currentTime = getDuration(currentValue);
        });
      });
    } else {
      bt = Icons.play_circle_fill_rounded;
      playMusic = true;
      audioPlayer.pause();
    }
  }

  dynamic getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text('Now Playing'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                currIndex = index;
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.volume_down_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    audioPlayer.setVolume(1.5);
                  }),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            color: getColor(),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Image(
                    image: songs[index].albumArtwork == null
                        ? AssetImage('images/music_gradient.jpg')
                        : FileImage(File(songs[index].albumArtwork)),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Text(songs[index].displayName),
                        Text(songs[index].artist),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Slider(
                    inactiveColor: Colors.black,
                    activeColor: Colors.yellowAccent,
                    min: minimumValue,
                    max: maximumValue,
                    value: currentValue,
                    onChanged: (value) {
                      currentValue = value;
                      if (maximumValue == currentValue) {
                        index += 1;
                        playMusic = true;
                        if (index >= songs.length) {
                          index = 0;
                        }
                        changeState(index);
                      } else {
                        audioPlayer
                            .seek(Duration(milliseconds: currentValue.round()));
                      }
                    },
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0, -15, 0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currentTime,
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500)),
                      Text(endTime,
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.yellowAccent,
          bottomNavigationBar: BottomAppBar(
            color: getColor(),
            shape: CircularNotchedRectangle(),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.yellowAccent, // button color
                        child: InkWell(
                          child: SizedBox(
                              child: Icon(
                            Icons.skip_previous,
                            size: 45,
                            color: Colors.black,
                          )),
                          onTap: () {
                            setState(() {
                              index -= 1;
                              playMusic = true;

                              if (index <= 0) {
                                if (index == 0) {
                                  index = index;
                                } else {
                                  index = songs.length + index;
                                }
                              }
                              changeState(index);
                            });
                          },
                        ),
                      ),
                    )),
                Spacer(),
                Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.yellowAccent, // button color
                        child: InkWell(
                          child: SizedBox(
                              child: Icon(
                            Icons.skip_next,
                            size: 45,
                            color: Colors.black,
                          )),
                          onTap: () {
                            setState(() {
                              index += 1;
                              playMusic = true;
                              if (index >= songs.length) {
                                index = 0;
                              }
                              changeState(index);
                            });
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellowAccent,
            child: Center(
              child: Icon(
                bt,
                size: 45.0,
              ),
            ),
            onPressed: () {
              setState(() {
                currIndex = index;
                changeState(index);
              });
            },
          ),
        ),
        onWillPop: () {
          currIndex = index;
          Navigator.of(context).pop();
        });
  }
}
