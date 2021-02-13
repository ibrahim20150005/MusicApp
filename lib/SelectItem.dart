import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';

import 'TabBarViewPages.dart';

int _selectedIndex = 0;
bool selectAll = false;
IconData iconData = Icons.check_circle_outline;
Color color = Colors.grey[700];

class SelectItem extends StatefulWidget {
  @override
  _SelectItemState createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select"),
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: color,
        child: ListSongs(Icons.check_circle_outline, 2),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.delete),
          label: 'Delete',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_sharp),
          label: 'Rename',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: 'Select All',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.yellowAccent,
      onTap: (value) {
        setState(() {
          if (value == 0) {
            for (int x = 0; x < songs.length; x++) {
              if (select[x] != null) {
                if (select[x].isSelect == true) {
                  print('--------------');
                  print(select[x].isSelect);
                  print("--------------");
                  songs.removeAt(x);
                  // select.remove(x);
                }
              }
            }
            _selectedIndex = value;
          } else if (value == 1) {
            print('$value');

            _selectedIndex = value;
          } else {
            print('$value');
            _selectedIndex = value;
            if (selectAll == false) {
              iconData = Icons.check_circle_rounded;
              selectAll = true;
              //          ListSongs(iconData, 3);
            } else {
              iconData = Icons.check_circle_outline;
              //            ListSongs(iconData, 4);
              selectAll = false;
            }
          }
        });
      },
    );
  }
}
