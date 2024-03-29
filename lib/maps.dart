


///////////////////////DEPRICATED FILE; CON BE REMOVED//

       ///////   //          //////
     //     //  //          //    //
    //     //  //          //     //
   //     //  //          //     //
  //     //  //          //     //
 //     //  //          //    //
 ///////   /////////   //////















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

  List<Marker> markers=<Marker>[];

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
        compassEnabled: true,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: _myLoc,
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller){
          mapController=controller;
          _setStyle(controller);
          _controller.complete(controller);
        }
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn_SearchNeraby",
              child: Icon(Icons.home, color: Colors.white,),
              onPressed: () {
                /*markers=[];
                  markers.add(
                    Marker(
                      markerId: MarkerId("1!"),
                      position: LatLng(0,0),
                      infoWindow: InfoWindow(
                          title: "Absolute Zero", snippet: "coords: 0,0"),
                      onTap: () {},
                    ),
                  );*/
                searchNearby(latitude, longitude);
              }
            ),
            SizedBox(width: 8.0),
            FloatingActionButton(
              heroTag: "btn_goToMyLoc",
              child: Icon(Icons.my_location, color: Colors.white,),
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(latitude, longitude), zoom: 15.0,),
                    ),
                  );
              }),
          ],
        ),
      ),
    );
  }

  void _handleResponse(data){
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        // 2
        places = PlaceResponse.parseResults(data['results']);
        // 3
        for (int i = 0; i < places.length; i++) {
          // 4
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {
                //Todo new nav
              },
            ),
          );
        }
      });
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


  // 1
  void searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear(); // 2
    });
    // 3
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=${widget.keyword}';

    // 4
    final response = await http.get(url);
    // 5
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    setState(() {
      searching = false; // 6
    });
  }







}




