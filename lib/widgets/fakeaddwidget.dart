import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'standartDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';


class fakeaddwidget extends StatefulWidget {
  createState() => _fakeaddwidgetS();
}

class _fakeaddwidgetS extends State<fakeaddwidget> {
  var moneyval=300.0;
  var moneyvalm=3.0;
  var safety="";
  @override
  void initState() {
    super.initState();
    moneyval=300.0;
    moneyvalm=3.0;
  }

  @override
  Widget build(BuildContext context) {
    moneyvalm=((moneyval*moneyval*moneyval)/40000).ceil()/100;
    safety=(moneyval>200.0)?", inklusive 3-Tage-Liefergarantie*":"";

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
      Row(
        children: <Widget>[
          SizedBox(width:20),
          Expanded(child: Text("Sie bieten $moneyvalm € $safety")),
        ],
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




