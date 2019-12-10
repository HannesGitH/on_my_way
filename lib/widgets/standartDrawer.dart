
import 'package:on_my_way/res/colors.dart';

import 'MyListTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'NotYetImplementedPage.dart';
import 'package:on_my_way/settingsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class standartDrawer extends StatelessWidget {
  standartDrawer({this.current=0});

  final current;

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
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      child: Image.asset('assets/omwicon.png'),
                      fit: BoxFit.fitHeight,
                    ),
                    decoration: BoxDecoration(
                        color: cMAIN_HELL,
                        gradient: LinearGradient(
                          colors: [cMAIN, cMAIN_HELL],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                  ),
                  MyListTile(
                    text: "Einstellungen",
                    icon: Icons.settings,
                    color: current==1?cMAIN:null,
                    onTap: () {
                      if(current!=1)settingsP(context);
                      else {Navigator.pop(context);}
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
            Drawer_BottomSection(),
          ],
        ),
      )
    ;
  }
}




class Drawer_BottomSection extends StatefulWidget{
  createState() => _Drawer_BottomSectionS();
}
class _Drawer_BottomSectionS extends State<Drawer_BottomSection> with SingleTickerProviderStateMixin{

  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller= AnimationController(duration: Duration(milliseconds: 300),vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return MoveUpAnim(controller: controller);
  }
}

class MoveUpAnim extends StatelessWidget{
  final AnimationController controller;
  MoveUpAnim({Key key, this.controller}):
        fortschritt= Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        ),),
        super(key: key);
  final Animation<double> fortschritt;

  build(context){
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder){
        return  Align(
          alignment: FractionalOffset.bottomCenter,
          child: Column(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0.0, fortschritt.value),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Divider(),
                        FeedBackTile(

                        ),
                      ],),
                  ],
                ),
              ),

                  ourPag(),
                  Column(
                    children: <Widget>[
                      MyListTile(
                        icon:Icons.supervised_user_circle,
                        text:"Über uns",
                        color: isActive?cMAIN:cGREY,
                        onTap: () {
                          toggleUs();
                        },
                      ),
                    ]
                  ),

            ],
          ),
        );
      },
    );
  }


  _open(){
    controller.forward();
  }
  _close(){
    controller.reverse();
  }

  void toggleFB(){
    if(isActive){
      _close();
    }
  }

  void toggleUs(){
    if(isActive){
      _close();
    }else{
      _open();
      isActive=true;
    }
  }
  bool isActive=false;
  bool isFB=false;


  Widget ourPag(){
    if(fortschritt.value<0.02){isActive=false;}else {isActive=true;}
    if(isActive){
      return Transform.scale(
        scale: fortschritt.value,
        child: Align(
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
                Text(" Der Rest",textAlign: TextAlign.left,),
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 1,
    );
  }
}



class FeedBackTile extends StatefulWidget{
  FeedBackTile();
  createState()=>_FeedBackTileS();
}

class _FeedBackTileS extends State<FeedBackTile>{
  bool isUp=false;
  build(context){
    if(isUp) {
      return Column(
        children: <Widget>[
          InkWell(
            onTap: (){_launchURL();},
            child: Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Icon(
                  Icons.mail,
                  color: cGREY,
                ),
                SizedBox(width: 9,),
                Text("www.OnMyWay.OMW@gmail.com",style: TextStyle(color: cLINK,)),
              ],
            ),
          ),
          MyListTile(
              icon: Icons.feedback,
              text: 'Feedback',
              color: cMAIN,
              onTap: () {
                setState(() {
                  isUp = !isUp;
                });
              }
          ),

        ],
      );
    }
    else{
      return MyListTile(
          icon:Icons.feedback,
          text:'Feedback',
          color: cGREY,
          onTap: () {
            setState((){isUp=!isUp;});
          }
      );
    }
  }
}


_launchURL() async {
  const url = 'mailto:www.OnMyWay.OMW@gmail.com?subject=Feedback&body=Hey%20OMW-Team,...';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
