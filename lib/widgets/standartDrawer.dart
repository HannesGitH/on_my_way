

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class standartDrawer extends StatelessWidget {
  standartDrawer({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
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
            ),
            // This container holds the align
            Container(
              // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Icon(Icons.feedback),
                                  SizedBox(width: 8.0,),
                                  Text('Feedback'),
                                ],
                              ),
                              onTap: () {
                              },
                            ),
                            ListTile(
                              title:Row(
                                children: <Widget>[
                                  Icon(Icons.supervised_user_circle),
                                  SizedBox(width: 8.0,),
                                  Text('Über uns'),
                                ],
                              ),
                              onTap: () {},
                            ),
                        ],
                        )
                    )
                )
            )
          ],
        ),
      )
    ;
  }
}