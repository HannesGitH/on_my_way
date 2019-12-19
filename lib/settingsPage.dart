import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'widgets/standartDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';


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
    MapsSettings mappps=new MapsSettings();
    return <Widget>[
      sHeadline(color: cMAIN, text: "Map Anbieter", icon: Icons.map,),
      mappps,
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
  sMapchooser({this.name="mapX",this.imagename="omwicon.png",this.chosenb=false,this.onset});

  var prefs=null;

  bool chosenb;

  Function onset;

  String name;
  String imagename;
  createState()=> _sMapchooserS();
}

class _sMapchooserS extends State<sMapchooser>{

  bool down=false;

  TapDownDetails tapDownDetails;


  @override
  Widget build(BuildContext context) {

    return sMapchoser(name:widget.name,imagename:widget.imagename);
  }


  Widget sMapchoser({name="mapX",imagename="omwicon.png"}){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: widget.chosenb?cMAIN_HELL:cWHITE,
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
                  down = false;
                  widget.onset();

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
}

class MapsSettings extends StatefulWidget{
  MapsSettings();


  void _showDialogGoogle(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Google Maps? Wirklich?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Google Maps macht es uns leider schwer, denn es ist ziemlich teuer."),
              SizedBox(height: 10),
              Text("Deshalb empfehlen wir die kostengünstigere variante MapBox"),
              SizedBox(height: 10),
              Text("Sollten Sie tatsächlich auf googles Dienste bestehen, haben sie folgende 4 Optionen:"),
              SizedBox(height: 15),
              Possibility("Standart","Sie bekommen ab erster Lieferung etwas weniger Belohnung, bis dahin sehen Sie Werbung.."),
              Possibility("Kaufen","Einmalig 2€, danach nie Werbung oder versteckte Kosten"),
              Possibility("Direkt","Sie zahlen direkt die Kosten die ihre Anfragen kosten"),
              Possibility("Werbung","naja es gibt halt einen kleinen Werbebanner.."),

            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Standart"),
              onPressed: () {
                notYetPage(context);
              },
            ),
            FlatButton(
              child: Text("Kaufen"),
              onPressed: () {
                notYetPage(context);
              },
            ),
            FlatButton(
              child: Text("Direkt"),
              onPressed: () {
                notYetPage(context);
              },
            ),
            FlatButton(
              child: Text("Werbung"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget Possibility(head,discription){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(head, style: TextStyle(color:cMAIN, fontWeight: FontWeight.w600),),
        Text(discription),
        SizedBox(height: 7,)
      ],
    );
  }




  @override
  State<MapsSettings> createState() {
    _MapsSettingsS a =new _MapsSettingsS();
    a.reado();
    return a;
  }
}

class _MapsSettingsS extends State<MapsSettings>{

  var prefs;
  var current=1;

  reado () {
    var key="MapProv";
    if(prefs==null){
      SharedPreferences.getInstance().then((instance){
        prefs=instance;
        setState(() {
          current= prefs.getInt(key) ?? 1;
        });
      });
    }else{
      setState(() {
        current=prefs.getInt(key) ?? 1;
      });
    }
  }

  writeo (curr) {
    var key="MapProv";
    if(prefs==null){
      SharedPreferences.getInstance().then((instance){
        prefs=instance;
        setState(() {
          current=curr;
          prefs.setInt(key,curr);
        });
      });
    }else{
      prefs.setInt(key,curr);
      setState(() {
        current=curr;
      });
    }
  }
  write1(){writeo(1);}
  write2(){widget._showDialogGoogle(context);writeo(2);}
  write3(){writeo(3);}

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        sMapchooser(name:"MapBox", imagename: "mapbox.png", chosenb: (current==1),onset: write1 ,),
        sMapchooser(name:"Google", imagename: "google.png", chosenb: (current==2),onset: write2 ,),
        sMapchooser(name:"OpenSM", imagename: "opensm.png", chosenb: (current==3),onset: write3 ,),
      ],
    );
  }

}

