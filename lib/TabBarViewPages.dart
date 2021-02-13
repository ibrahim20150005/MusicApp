import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:hello_world/MyHome.dart';

import 'SelectItem.dart';
import 'main.dart';
import 'dart:io';

// ignore: must_be_immutable
class ListSongs extends StatefulWidget {
  IconData iconData;
  int choise;
  ListSongs.oreginal();
  ListSongs(this.iconData, this.choise);
  @override
  _ListSongsState createState() => _ListSongsState(iconData, choise);
}

class Favorite {
  bool isFav;
  SongInfo songInfoFav;
}

class Select {
  bool isSelect;
  SongInfo songInfoFav;
}

List<Favorite> fav = List(songs.length);
List<Select> select = List(songs.length);
Favorite f;
Select s;

//IconData iconFav = Icons.favorite_border_outlined;

class _ListSongsState extends State<ListSongs> {
  IconData iconData;

  int choise;
  _ListSongsState(this.iconData, this.choise);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              f = new Favorite();
              s = new Select();
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHome(index)));
                  },
                  onLongPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SelectItem()),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: songs[index].albumArtwork == null
                        ? AssetImage('images/music_gradient.jpg')
                        : FileImage(File(songs[index].albumArtwork)),
                  ),
                  title: Text(songs[index].displayName),
                  subtitle: Text(songs[index].artist),
                  trailing: IconButton(
                      icon: choise == 1
                          ? fav[index] == null || fav[index].isFav == false
                              ? Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.yellowAccent,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.yellowAccent,
                                )
                          : select[index] == null ||
                                  select[index].isSelect == false
                              ? Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.yellowAccent,
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: Colors.yellowAccent,
                                ),
                      onPressed: () {
                        setState(() {
                          if (choise == 1) {
                            if (fav[index] == null ||
                                fav[index].isFav == false) {
                              f.isFav = true;
                              f.songInfoFav = songs[index];
                              fav[index] = f;
                            } else {
                              f.isFav = false;
                              f.songInfoFav = songs[index];
                              fav[index] = f;
                            }
                          } else {
                            if (select[index] == null ||
                                select[index].isSelect == false) {
                              s.isSelect = true;
                              s.songInfoFav = songs[index];
                              select[index] = s;
                            } else {
                              s.isSelect = false;
                              s.songInfoFav = songs[index];
                              select[index] = s;
                            }
                          }
                        });
                      }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ListView.builder(
              itemCount: fav.length,
              itemBuilder: (context, index) {
                if (fav[index] != null) {
                  if (fav[index].isFav == true) {
                    return Card(
                      //  <-- Card widget -->
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: fav[index]
                                      .songInfoFav
                                      .albumArtwork ==
                                  null
                              ? AssetImage('images/music_gradient.jpg')
                              : FileImage(
                                  File(fav[index].songInfoFav.albumArtwork)),
                        ),
                        title: Text(fav[index].songInfoFav.displayName),
                        subtitle: Text(fav[index].songInfoFav.artist),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyHome(index)));
                        },
                      ),
                    );
                  } else {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              }),
        ),
      ),
    );
  }
}
