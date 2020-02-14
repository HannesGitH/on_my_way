import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:http/http.dart' as http;

class DevelPage extends StatelessWidget {
  DevelPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(height:100,),
      appBar: AppBar(
        title: Text("You should not be here"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RawMaterialButton(
              fillColor: cMAIN,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: cMAIN_DARK)
              ),
              child: Text("Post testData",style: TextStyle(color: cWHITE),),
              onPressed: (){
                //
                try {
                  var uriResponse = http.post('https://hannes.godigitalnow.de',
                      body: {'pass':'HannesTest','author': 'hannes_dev_test',  'title':'test_title','location_at':'berlin_this_is_invalid', 'location_to':'berlin_this_is_invalid','weight':'1000','price':'333'});
                  uriResponse.then((v){print(v.body);print("-----------------------");});
                }finally{

                }
              },
            ),
          ],
        ),
      ),
    );
  }








}


void devPage(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DevelPage()),
  );
}