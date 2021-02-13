import 'package:flutter/material.dart';
import 'TabBarViewPages.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Songs list",
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.music_note), text: "All songs"),
              Tab(icon: Icon(Icons.favorite), text: "My favorites")
            ],
          ),
        ),
        body: TabBarView(children: [
          ListSongs(Icons.favorite_border_outlined, 1),
          Favorites(),
        ]),
      ),
    );
  }
}
