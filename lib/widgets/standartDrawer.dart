

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class standartDrawer extends StatelessWidget {
  standartDrawer({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
// Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('On My Way',
                  style: (TextStyle(
                      color: Colors.white,
                      fontSize: 20.2
                  ))),
              decoration: BoxDecoration(
                  color: Colors.teal[200],
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal[100]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.settings),
                  SizedBox(width: 8.0,),
                  Text('Einstellungen'),
                ],
              ),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 8.0,),
                  Text('Anmelden'),
                ],
              ),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
          ],
        ),
      )
    ;
  }
}