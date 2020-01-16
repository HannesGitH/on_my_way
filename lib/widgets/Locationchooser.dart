import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'standartDrawer.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


class Locationchooser extends StatefulWidget {
  Locationchooser();
  createState() => _LocationchooserS();
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
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 150,
              child: MapboxMap(
                  compassEnabled: true,
                  //myLocationButtonEnabled: false,
                  myLocationEnabled: true,
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
        ],
      );
  }
}