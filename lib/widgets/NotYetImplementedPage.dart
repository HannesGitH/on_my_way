import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class NotYetImplementedPage extends StatelessWidget {
  NotYetImplementedPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(height:100,),
      appBar: AppBar(
        title: Text("NOT YET IMPLEMENTED"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Placeholder Dummy , just go back"),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    child: Card(
                      child: Text('NÖ'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
