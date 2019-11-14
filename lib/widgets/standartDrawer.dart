
import 'MyListTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'NotYetImplementedPage.dart';

class standartDrawer extends StatelessWidget {
  standartDrawer();


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
                  MyListTile(
                    text: "Einstellungen",
                    icon: Icons.settings,
                    onTap: () {
                      notYetPage(context);
                    },
                  ),
                  MyListTile(
                    icon:Icons.person,
                    text:'Anmelden',
                    onTap: () {
                      notYetPage(context);
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
                            MyListTile(
                              icon:Icons.feedback,
                              text:'Feedback',
                              color: Colors.black54,
                              onTap: () {
                                notYetPage(context);}
                            ),
                            UeberUns(

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

class UeberUns extends StatefulWidget{
  @override
  _ueberUnsS createState() => _ueberUnsS();
}

class _ueberUnsS extends State<UeberUns>{

  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    if(isActive){
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Project OnMyWay",
                  style: TextStyle(
                    fontSize: 25,
                  ),),
                  SizedBox(
                    height: 8,
                  ),
                  Text(" Hannes Hattenbach",textAlign: TextAlign.left,),
                  Text(" Linus Ostermayer",textAlign: TextAlign.left,),
                  Text(" Esther Helmi",textAlign: TextAlign.left,),
                  Text(" Cora Fritz",textAlign: TextAlign.left,),
                  Text(" Thea Doerge",textAlign: TextAlign.left,),
                ],
              ),
            ),
          ),
            MyListTile(
            icon:Icons.supervised_user_circle,
              text:"Über uns",
              color: Colors.teal,
              onTap: () {
                  toggleUs();
              },
            )
          ]
      );
    }
    return MyListTile(
      icon:Icons.supervised_user_circle,
      text:"Über uns",
      color: Colors.black54,
      onTap: () {
        toggleUs();
      },
    );
  }

  void toggleUs(){
    setState(() {
      isActive=!isActive;
    });
  }
}