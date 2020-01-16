import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'standartDrawer.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


class Locationchooser extends StatefulWidget {

  EagerGestureRecognizer skoup =EagerGestureRecognizer();

  Locationchooser({Key key}) : super(key: key);
  //final key;
  State<StatefulWidget> createState() => _LocationchooserS();
}

class _LocationchooserS extends State<Locationchooser> {

  static double latitude = 52.5201727;
  static double longitude = 13.4035465;

  Completer<MapboxMapController> _controller = Completer();
  MapboxMapController mapController;

  static final CameraPosition _myLoc=
  CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 12,
    tilt: 2,
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          Container(
            decoration:  BoxDecoration(
                boxShadow:[
                BoxShadow(
                color: cGREY,
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: -8.5, // has the effect of extending the shadow
                offset: Offset(
                  1.0, // horizontal
                  4.0, // vertical
                ),
              )
            ],
            //borderRadius: BorderRadius.all(...),
            //gradient: LinearGradient(),
            ),
            child: ClipRRect(
              //key: widget.key,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 150,
                child: MapboxMap(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[ //todo das verstehen haha copy pasta
                      new Factory<OneSequenceGestureRecognizer>(
                      () => new EagerGestureRecognizer(),
                      ),
                      ].toSet(),
                    compassEnabled: false,
                    myLocationTrackingMode: MyLocationTrackingMode.None,
                    myLocationEnabled: false,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: _myLoc,
                    //mapType: MapType.normal,
                    //markers: Set<Marker>.of(markers),
                    onMapCreated: (MapboxMapController controller){
                      mapController=controller;
                      _controller.complete(controller);
                    }
                ),
              ),
            ),
          ),
        ],
      );
  }
}