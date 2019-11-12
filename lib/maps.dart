import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data/place_response.dart';
import 'data/result.dart';
import 'data/error.dart';

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
  static const String _API_KEY = 'EMPTY';

  static double latitude = 52.4320773;
  static double longitude = 13.2673763;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";




  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _myLoc=
  CameraPosition(target: LatLng(latitude, longitude),);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
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
}




