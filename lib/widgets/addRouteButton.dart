import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';

class addRouteButton extends StatelessWidget{
  addRouteButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RotatedBox(
        quarterTurns: 3,
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
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.loupe, //add location , draft , control point duplicate , add circle, loupe,markunread mailbox ,work
                      color: cWHITE,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text("ADD PACKET",
                    style: TextStyle(
                      color: cWHITE,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: onPressed,
          shape: StadiumBorder(),
        ),
      ),
    );
  }

}