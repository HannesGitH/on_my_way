
import 'MyListTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'NotYetImplementedPage.dart';

class standartDrawer extends StatelessWidget {
  standartDrawer();


  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
// Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('On My Way',
                        style: (TextStyle(
                            color: Colors.white,
                            fontSize: 20.2
                        ))),
                    decoration: BoxDecoration(
                        color: Colors.teal[200],
                        gradient: LinearGradient(
                          colors: [Colors.teal, Colors.teal[100]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                  ),
                  MyListTile(
                    text: "Einstellungen",
                    icon: Icons.settings,
                    onTap: () {
                      notYetPage(context);
                    },
                  ),
                  MyListTile(
                    icon:Icons.person,
                    text:'Anmelden',
                    onTap: () {
                      notYetPage(context);
                    },
                  ),
                ],
              ),
            ),
            // This container holds the align
            Drawer_BottomSection(),
          ],
        ),
      )
    ;
  }
}




class Drawer_BottomSection extends StatefulWidget{
  createState() => _Drawer_BottomSectionS();
}
class _Drawer_BottomSectionS extends State<Drawer_BottomSection> with SingleTickerProviderStateMixin{

  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller= AnimationController(duration: Duration(milliseconds: 400),vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return MoveUpAnim(controller: controller);
  }
}

class MoveUpAnim extends StatelessWidget{
  final AnimationController controller;
  MoveUpAnim({Key key, this.controller}):
        fortschritt= Tween<double>(
          begin: 0.0,
          end: -80.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        ),),
        super(key: key);
  final Animation<double> fortschritt;

  build(context){
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder){
        return Container(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, fortschritt.value),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Divider(),
                                MyListTile(
                                    icon:Icons.feedback,
                                    text:'Feedback',
                                    color: Colors.black54,
                                    onTap: () {
                                      notYetPage(context);}
                                ),
                              ],),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          ourPag(),
                          Column(
                            children: <Widget>[
                              MyListTile(
                                icon:Icons.supervised_user_circle,
                                text:"Über uns",
                                color: isActive?Colors.teal:Colors.black54,
                                onTap: () {
                                  toggleUs();
                                },
                              ),
                            ]
                          ),
                        ],
                      ),
                    ],
                ),
            ),
        );
      },
    );
  }

  _open(){
    controller.forward();
  }
  _close(){
    controller.reverse();
  }

  void toggleUs(){
    if(isActive){
      _close();
    }else{
      _open();
      isActive=true;
    }
  }
  bool isActive=false;


  Widget ourPag(){
    if(fortschritt.value>-2){isActive=false;}else {isActive=true;}
    if(isActive){
      return Transform.translate(
        offset: Offset(0.0, fortschritt.value),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Project OnMyWay",
                  style: TextStyle(
                    fontSize: 25,
                  ),),
                SizedBox(
                  height: 8,
                ),
                Text(" Hannes Hattenbach",textAlign: TextAlign.left,),
                Text(" Linus Ostermayer",textAlign: TextAlign.left,),
                Text(" Esther Helmi",textAlign: TextAlign.left,),
                Text(" Cora Fritz",textAlign: TextAlign.left,),
                Text(" Thea Doerge",textAlign: TextAlign.left,),
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 1,
    );
  }

}


