import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'widgets/standartDrawer.dart';

class settingsPage extends StatelessWidget {
  settingsPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: standartDrawer(current: 1,),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
            centerTitle: true,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Einstellungen'),
            ),
            actions: <Widget>[

            ],

          ),
          SliverList(
            delegate: SliverChildListDelegate(
                [
              ...[
                SizedBox(height: 50,),
              ],
              ...Einstellungen(),
              ...[
                SizedBox(height: 50,),
              ],
            ]
            ), //Einstellungen(),
          ),
        ],
      ),
    );
  }

List<Widget> Einstellungen(){
    return <Widget>[
      sHeadline(color: cMAIN, text: "Map Anbieter", icon: Icons.map,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("MapBox",style: TextStyle(color: cMAIN_DARK),),
          Text("Google",style: TextStyle(color: cMAIN_DARK),),
          Text("OpenSM",style: TextStyle(color: cMAIN_DARK),),
        ],
      ),


      ];
}

Widget sHeadline({icon=Icons.insert_emoticon,text="headline",color=cBLACK}){
  return Column(
    children: <Widget>[
      Container(
        /*decoration: BoxDecoration(
            color: cMAIN_HELL,
            borderRadius: BorderRadius.circular(20),
        ),*/
        child: Column(
          children: <Widget>[
            SizedBox(height: 12,),
            Row(
              children: <Widget>[
                SizedBox(width: 25,),
                Icon(icon,color:color,),
                SizedBox(width: 10,),
                Text(text,style: TextStyle(color: color, fontSize: 20),),
              ],
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
      SizedBox(height: 5,),
    ],
  );
}

Widget sToggleLine(){
}



}


void settingsP(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => settingsPage()),
  );
}