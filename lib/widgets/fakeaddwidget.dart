import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'standartDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'Locationchooser.dart';


class fakeaddwidget extends StatefulWidget {
  createState() => _fakeaddwidgetS();
}

class _fakeaddwidgetS extends State<fakeaddwidget> {

  var moneyval=300.0;
  var moneyvalm=3.0;
  var safety="";
  var pSize=20;

  final Key key2=UniqueKey();
  final key = GlobalKey();


  @override
  void initState() {
    super.initState();
    moneyval=300.0;
    moneyvalm=3.0;
  }

  @override
  Widget build(BuildContext context) {
    moneyvalm=((moneyval*moneyval*moneyval)/80000).ceil()/100;
    safety=(moneyval>270.0)?", inklusive 3-Tage-Liefergarantie*":"";

    return Scaffold(
      endDrawer: standartDrawer(current: 1,),
      body: CustomScrollView(
        dragStartBehavior: DragStartBehavior.start,
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
              title: Text('OMW neues Paket erstellen'),
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
      headline(
        child: Row(
          children: <Widget>[
            Icon(Icons.monetization_on),
            SizedBox(width:5,),
            Text("Sie bieten $moneyvalm €",style: TextStyle(
              fontSize: 16,
            ),),
            Text("$safety",style: TextStyle(
              color: cMAIN_DARK,
            ),),
          ],
        )
      ),
      Slider.adaptive(
        value: moneyval??300,
        onChanged: (newVal){
          setState(() {
            moneyval = newVal;
          });
        },
        min: 0,
        max: 1000,
        //divisions: 20,
        label: "$moneyval ct",
      ),
      SizedBox(height: 30,),
      headline(child: Row(
        children: <Widget>[
          Icon(Icons.sms_failed,),
          SizedBox(width: 5,),
          Text("Titel: ",style: TextStyle(
            fontSize: 16,
          ),),
          Expanded(
            child: TextField(
              cursorColor: cGREY,
              textCapitalization: TextCapitalization.words,
              style: TextStyle(
                color:cMAIN_DARK,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Titel hier eingeben'
              ),
            ),
          ),
        ],
      ),),
      SizedBox(height:30,),
      headline(
          child: Locationchooser(
            child: Row(
              children: <Widget>[
                Icon(Icons.navigation),
                SizedBox(width:5,),
                Text("Von",style: TextStyle(
                  fontSize: 16,
                ),),
              ],
            ),
          )
      ),
      
      SizedBox(height: 30,),
      headline(
          child: Locationchooser(
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on),
                SizedBox(width:5,),
                Text("Nach",style: TextStyle(
                  fontSize: 16,
                ),),
              ],
            ),
          )
      ),

      SizedBox(height: 30,),
      headline(
          child: Row(
            children: <Widget>[
              Icon((pSize<20)?Icons.mail_outline:((pSize<200)?Icons.email:((pSize<800)?Icons.shopping_basket:Icons.business_center))),
              SizedBox(width:5,),
              Text("Paketgröße: ca. ",style: TextStyle(
                fontSize: 16,
              ),),
              Text("$pSize Gramm",style: TextStyle(
                color: cMAIN_DARK,
                fontSize: 16,
              ),),
            ],
          )
      ),
      Slider.adaptive(
        value: (pSize??20).toDouble(),
        onChanged: (newVal){
          setState(() {
            pSize = newVal.round();
          });
        },
        min: 0,
        max: 2000,
        //divisions: 20,
        //label: "$moneyval ct",
      ),
      SizedBox(height: 30,),
      SizedBox(height:20,),
      headline(
        child: RawMaterialButton(
          fillColor: cMAIN,
          splashColor: cMAIN_HELL,
          child: Padding(padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
            child:Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: cWHITE,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text("Paket einstellen",
                  style: TextStyle(
                    color: cWHITE,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          onPressed: (){Navigator.pop(context);},
          shape: StadiumBorder(),
        ),
      ),
      SizedBox(height: 10,),



      bottomsequence(),
    ];
  }

  Widget bottomsequence(){
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("*momentan können wir aufgrund der Einführungsphase noch keine Garantie bieten, für mehr infos besuchen Sie doch gerne unsere Website.",
                  style: TextStyle(
                    color: cGREY,
                    fontSize:8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15,),
        ],
      )
    ;
  }

}


class headline extends StatefulWidget {
  headline({@required this.child});

  final Widget child;

  createState() => _headlineS();
}

class _headlineS extends State<headline> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Row(
        children: <Widget>[
          SizedBox(width:20),
          Expanded(child: widget.child),
          SizedBox(width:20),
        ],
      );
  }
}

