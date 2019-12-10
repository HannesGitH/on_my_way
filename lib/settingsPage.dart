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
          sMapchoser(name:"MapBox", imagename: "mapbox.png"),
          sMapchoser(name:"Google", imagename: "google.png"),
          sMapchoser(name:"OpenSM", imagename: "opensm.png"),
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

/*class sMapchoser extends statefulWidget{

    sMapchoser({name="mapX",imagename="omwicon.png"});
    createState()=> _sMapchoserS();
}*/

Widget sMapchoser({name="mapX",imagename="omwicon.png"}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name,style: TextStyle(color: cMAIN_DARK),),
        SizedBox(height: 7,),
        GestureDetector(
          onTap: () {
            //todo
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width:60,
              height:60,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Image.asset('assets/'+imagename),
              ),
            ),
          ),
        ),
      ],
    );
}


}


void settingsP(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => settingsPage()),
  );
}