import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data/place_response.dart';
import 'data/result.dart';
import 'data/error.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final String keyword;
  Maps(this.keyword);



  @override
  State<Maps> createState() {
    return _Maps();
  }
}

class _Maps extends State<Maps> {

  static const String _API_KEY = 'AIzaSyDL-3Yf20flTdmx6OOJLb2eIa9qc43LXNU';

  static double latitude = 52.5201727;
  static double longitude = 13.4035465;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";



  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  Completer<GoogleMapController> _controller = Completer();



  static final CameraPosition _myLoc=
  CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 12,
    tilt: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(

        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _myLoc,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          mapController=controller;
          _setStyle(controller);
          _controller.complete(controller);
        }
    ),);
  }

  void _handleResponse(data){
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {

    } else {
      print(data);
    }
  }

  void _setStyle(GoogleMapController controller) async {

    print("style set");

    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }



  GoogleMapController mapController;




  @override
  void initState() {

    var location = new Location();
    location.getLocation().then((result) {
      setState(() {
        latitude = result.latitude;
        longitude = result.longitude;
      });
    },
        onError: (error){
            //somethin went wrong with position aquiring possibly accesss denied
        });

    location.onLocationChanged().listen((LocationData result) {
      setState(() {
        /*print("alt: $longitude");
        latitude = result.latitude;
        longitude = result.longitude;
        print(longitude);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(latitude, longitude), zoom: 20.0),
          ),
        )*/
      });
    });


  }








}




