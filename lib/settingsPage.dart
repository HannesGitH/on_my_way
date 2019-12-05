import 'package:flutter/material.dart';
import 'widgets/standartDrawer.dart';

class settingsPage extends StatelessWidget {
  settingsPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: standartDrawer(current: 1,),
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text("Einstellungen"),
        centerTitle: true,
        actions: <Widget>[

        ],
      ),
      body: Center(
        child: Text("congrats, aber hier ist noch nichts"),
      ),
    );
  }





}


void settingsP(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => settingsPage()),
  );
}