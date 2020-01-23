import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_my_way/res/colors.dart';
import 'package:on_my_way/widgets/NotYetImplementedPage.dart';
import 'standartDrawer.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;


class Locationchooser extends StatefulWidget {

  EagerGestureRecognizer skoup =EagerGestureRecognizer();

  Locationchooser({Key key, this.child}) : super(key: key);
  //final key;
  final Widget child;
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

  Circle start;
  Circle starttmp;

  TextEditingController inputfield = TextEditingController() ;

  Future<Map<String, dynamic>> fetchPost(String searchText,) async {
    String st=Uri.encodeFull(searchText);
    var response;
    try{response =
    await http.get('https://api.mapbox.com/geocoding/v5/mapbox.places/'+st+'.json?access_token=pk.eyJ1IjoiaGFubmVzb213IiwiYSI6ImNrM3NlbXc4czA0N3Yzbm8xcTF2azdxMzUifQ.qgd9llxTGr6HvXQwcz99Cg'
        +'&limit=1'
        +'&language=de'
        +'&proximity='+longitude.toString()+','+latitude.toString()
    );}catch(e){
      onError();
    }

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  /*Future<http.Response> fetchPost(String searchText,) {
    String st=Uri.encodeFull(searchText);
    return http.get('https://api.mapbox.com/geocoding/v5/mapbox.places/'+st+'.json?access_token=pk.eyJ1IjoiaGFubmVzb213IiwiYSI6ImNrM3NlbXc4czA0N3Yzbm8xcTF2azdxMzUifQ.qgd9llxTGr6HvXQwcz99Cg'
        +'&limit=1'
        +'&language=de'
        +'&proximity='+longitude.toString()+','+latitude.toString()
    );
  }*/

  Future<Map<String, dynamic>> fetchLocationName(lat,long) async {
    String lats=Uri.encodeFull(lat.toString());
    String longs=Uri.encodeFull(long.toString());
    var response;
    try{response =
    await http.get('https://api.mapbox.com/geocoding/v5/mapbox.places/'+longs+','+lats+'.json?access_token=pk.eyJ1IjoiaGFubmVzb213IiwiYSI6ImNrM3NlbXc4czA0N3Yzbm8xcTF2azdxMzUifQ.qgd9llxTGr6HvXQwcz99Cg'
        +'&limit=1'
        +'&language=de'
        +'&types=address'
    );}catch(e){
      onError();
    }

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      onError();
      throw Exception('Failed to load post');
    }
  }

  /*
  Future<http.Response> fetchLocationName(lat,long) {
    String lats=Uri.encodeFull(lat.toString());
    String longs=Uri.encodeFull(long.toString());
    return http.get('https://api.mapbox.com/geocoding/v5/mapbox.places/'+longs+','+lats+'.json?access_token=pk.eyJ1IjoiaGFubmVzb213IiwiYSI6ImNrM3NlbXc4czA0N3Yzbm8xcTF2azdxMzUifQ.qgd9llxTGr6HvXQwcz99Cg'
        +'&limit=1'
        +'&language=de'
        +'&types=address'
    );
  }*/

  @override
  void initState() {
    super.initState();
  }

  bool isok=false;

  void onError(){
    inputfield.text = "Probier`s nochmal";
    isok=false;
  }
  void onSuccess(coords){
    isok=true;
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.child??SizedBox(width: 1,),
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: inputfield,
                  onSubmitted: (searchString){
                    try{
                    fetchPost(searchString).then((value) {
                        try{Map<String, dynamic> feature0 = value['features'][0];
                        var coords = feature0['center'];
                        print(coords);
                        var nname = feature0['text_de'];
                        try {
                          mapController.removeCircle(start);
                        } catch (e) {}
                        mapController.addCircle(
                            CircleOptions(
                              geometry: LatLng(coords[1]+.0, coords[0]+.0),
                              circleColor: "white",
                              circleOpacity: 0.5,
                              circleRadius: 10,
                              circleStrokeColor: "teal",
                              circleStrokeWidth: 2,
                            )
                        ).then((circle) {
                          start = circle;
                        });
                        mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(coords[1]+.0, coords[0]+.0), zoom: 12.0,
                            ),
                          ),
                        );
                        inputfield.text = nname;
                        onSuccess(coords);
                        print(nname);}catch(e){onError();}
                      });
                    }on Exception catch (err){
                      onError();
                    }

                  },
                  cursorColor: cGREY,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                    color:cMAIN_DARK,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ort hier eingeben'
                  ),
                ),
              ),
            ],
          ),
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
                  onMapClick: (point,coordi){
                    try{mapController.removeCircle(start);}catch(e){}
                    mapController.addCircle(
                        CircleOptions(
                          geometry: coordi,
                          circleColor: "white",
                          circleOpacity: 0.5,
                          circleRadius: 10,
                          circleStrokeColor: "teal",
                          circleStrokeWidth: 2,
                        )
                    ).then((circle){starttmp=circle;});
                    inputfield.text="Adresse wird berechnet..";
                    try{
                    fetchLocationName(coordi.latitude,coordi.longitude).then((value) {try{
                        Map<String, dynamic> feature0 = value['features'][0];
                        var nname = feature0['text_de'];
                        var nnum = feature0['address'];
                        inputfield.text = nname + " " + nnum;
                        onSuccess(coordi);
                        start = starttmp;}catch(e){onError();}
                    });}catch (err){
                        mapController.addCircle(
                            CircleOptions(
                              geometry: coordi,
                              circleColor: "white",
                              circleOpacity: 0.5,
                              circleRadius: 10,
                              circleStrokeColor: "teal",
                              circleStrokeWidth: 2,
                            )
                        );
                        onError();
                      }

                  },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[ //todo das verstehen haha copy pasta
                      Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
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
                    },
                ),
              ),
            ),
          ),
        ],
      );
  }
}

class MapSRes {
  final int userId;
  final int id;
  final String title;
  final String body;

  MapSRes({this.userId, this.id, this.title, this.body});

  factory MapSRes.fromJson(Map<String, dynamic> json) {
    return MapSRes(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}