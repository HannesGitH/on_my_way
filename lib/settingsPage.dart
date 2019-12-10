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
      body: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Einstellungen(),
            SizedBox(height: 100,),
            Text("mehr Einstellungen werden folgen"),
          ],
        ),
      ),
    );
  }

Widget Einstellungen(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("ah"),
                Text("ah"),
                Text("ah"),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("ah"),
                Text("ah"),
                Text("ah"),
              ],
            ),
          ],
        ),
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