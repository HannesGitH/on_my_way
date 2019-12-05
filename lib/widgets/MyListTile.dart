import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  MyListTile({this.onTap,@required this.icon,@required this.text,this.width=9.0,this.color=Colors.black});

  final GestureTapCallback onTap;
  final IconData icon;
  final String text;
  var width=8.0;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(this.icon,
            color: this.color,),
          SizedBox(width: this.width,),
          Text(this.text,
          style: TextStyle(
            color: this.color,
          ),),
        ],
      ),
      onTap: () {
        this.onTap();
      },
    );
  }
}