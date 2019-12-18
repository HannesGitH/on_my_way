import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'widgets/standartDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      MapsSettings(),


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


class sMapchooser extends StatefulWidget{
  sMapchooser({this.name="mapX",this.imagename="omwicon.png"});

  var prefs=null;

  String name;
  String imagename;
  createState()=> _sMapchooserS();
}

class _sMapchooserS extends State<sMapchooser>{

  bool down=false;
  bool chosen= false;

  TapDownDetails tapDownDetails;


  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((instance){widget.prefs=instance;});

    print(reado("mapProv"));
    chosen=(reado("mapProv")==1);//todo nicht eins sonder halt ja

    return sMapchoser(name:widget.name,imagename:widget.imagename);
  }


  Widget sMapchoser({name="mapX",imagename="omwicon.png"}){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: chosen?cMAIN_HELL:cWHITE,
        width: 90,
        height:100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name,style: TextStyle(color: cMAIN_DARK),),
            SizedBox(height: 7,),
            GestureDetector(
              onTapDown: (pointer) {
                setState(() {
                  down=true;
                  tapDownDetails=pointer;
                });
              },
              onTapUp: (pointer){
                setState(() {
                  write("mapProv",chosen?0:1); //todo nicht eins sonder halt ja
                  down = false;
                });
              },
              onTapCancel: (){
                setState(() {
                  down = false;
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width:down?50:60,
                  height:down?50:60,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image.asset('assets/'+imagename),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  reado (key) {
    rread(prefs){
      return (prefs.getInt(key) ?? 0);
    }

    if(widget.prefs==null){
      SharedPreferences.getInstance().then((instance){return rread(instance);});
    }else{
      return rread(widget.prefs);
    }
  }

  write (key,value) {
    rread(prefs){
      prefs.setInt(key,value);
    }

    if(widget.prefs==null){
      SharedPreferences.getInstance().then((instance){return rread(instance);});
    }else{
      return rread(widget.prefs);
    }
  }



}

class MapsSettings extends StatefulWidget{
  MapsSettings();
  createState()=> _MapsSettingsS();
}

class _MapsSettingsS extends State<MapsSettings>{

  var prefs;


  reado (key) {
    rread(prefs){
      return (prefs.getInt(key) ?? 0);
    }

    if(prefs==null){
      SharedPreferences.getInstance().then((instance){
        prefs=instance;
        setState(() {

        });
      });
    }else{
      setState(() {
        prefs.getInt(key) ?? 0)
      });

    }
  }

  write (key,value) {
    rread(prefs){
      prefs.setInt(key,value);
    }

    if(widget.prefs==null){
      SharedPreferences.getInstance().then((instance){return rread(instance);});
    }else{
      return rread(widget.prefs);
    }
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((instance){return rread(instance);});
    SharedPreferences.getInstance().then((instance){

    });
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        sMapchooser(name:"MapBox", imagename: "mapbox.png"),
        sMapchooser(name:"Google", imagename: "google.png"),
        sMapchooser(name:"OpenSM", imagename: "opensm.png"),
      ],
    );
  }

}