import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class NotYetImplementedPage extends StatelessWidget {
  NotYetImplementedPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOT YET IMPLEMENTED"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Placeholder Dummy , just go back"),
      ),
    );
  }





}


void notYetPage(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NotYetImplementedPage()),
  );
}
