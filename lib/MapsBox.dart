
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'data/place_response.dart';
import 'data/result.dart';
import 'data/error.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;


class BMaps extends StatefulWidget {



  final String keyword;
  BMaps(this.keyword);

  @override
  State<BMaps> createState() {
    _BMaps a = _BMaps();
    Admob.initialize("ca-app-pub-3059560602817026~8825208552");
    a.reado();
    return a;
  }
}

class _BMaps extends State<BMaps> {

  var current=1;
  var prefs;

  reado () {
    var key="MapProv";
    if(prefs==null){
      SharedPreferences.getInstance().then((instance){
        prefs=instance;
        setState(() {
          current= prefs.getInt(key) ?? 1;
        });
      });
    }else{
      setState(() {
        current=prefs.getInt(key) ?? 1;
      });
    }
  }

  static const String _API_KEY = 'AIzaSyDL-3Yf20flTdmx6OOJLb2eIa9qc43LXNU';

  static double latitude = 52.5201727;
  static double longitude = 13.4035465;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";



  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  Completer<MapboxMapController> _controller = Completer();
  Completer<gm.GoogleMapController> _gmcontroller = Completer();
  Completer<WebViewController> _wvcontroller = Completer();

  //List<Marker> markers=<Marker>[];

  static final CameraPosition _myLoc=
  CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 12,
    tilt: 2,
  );
  static final gm.CameraPosition _gmmyLoc=
  gm.CameraPosition(
    target: gm.LatLng(latitude, longitude),
    zoom: 12,
    tilt: 2,
  );

  @override
  Widget build(BuildContext context) {
    //FirebaseAdMob.instance.initialize(appId: "ca-app-pub-3059560602817026~8825208552");


    reado(); /////ziemlich unschön wegen dauerschleife.. besser wär iwas anderes deshalb teigtl t o d o aber geht iwie doch weil nur bei dirty state reload ausgelö´t wird

    /*if(current==2){
      myBanner
      // typically this happens well before the ad is shown
        ..load()
        ..show(
          // Positions the banner ad 60 pixels from the bottom of the screen
          anchorOffset: 80.0,
          // Positions the banner ad 10 pixels from the center of the screen to the right
          horizontalCenterOffset: 0.0,
          // Banner Position
          anchorType: AnchorType.top,
        );
    }else{
      try{myBanner..dispose();}catch(e){}
      myBanner..dispose();
    }*/

    return Scaffold(
      //bottomSheet: AdmobBanner(adUnitId: "ca-app-pub-3940256099942544/6300978111",adSize:AdmobBannerSize.FULL_BANNER),
      body: mapmitad(),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
                heroTag: "btn_SearchNeraby",
                child: Icon(Icons.home, color: (current==1)?cWHITE:cACCENT,), //testpupose
                onPressed: () {
                  searchNearby(latitude, longitude);
                }
            ),
            SizedBox(width: 8.0),
            FloatingActionButton(
                heroTag: "btn_goToMyLoc",
                child: Icon(Icons.my_location, color: cWHITE,),
                onPressed: () {
                  switch(current){
                    case 1:
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(latitude, longitude), zoom: 15.0,),
                        ),
                      );break;

                    case 2:
                      gmmapController.animateCamera(
                        gm.CameraUpdate.newCameraPosition(
                          gm.CameraPosition(
                            target: gm.LatLng(latitude, longitude), zoom: 15.0,),
                        ),
                      );break;
                  }

                }),
          ],
        ),
      ),

    );
  }

  Widget mapmitad(){
    switch (current){
      case 2:
        return Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            gm.GoogleMap(
                compassEnabled: true,
                //myLocationButtonEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: _gmmyLoc,
                //mapType: MapType.normal,
                //markers: Set<Marker>.of(markers),
                onMapCreated: (gm.GoogleMapController controller) {
                  gmmapController = controller;
                  _setStyle(controller);
                  _gmcontroller.complete(controller);
                }
            ),
            Container(
                color: cWHITE,
                child: AdmobBanner(
                    adUnitId: "ca-app-pub-3940256099942544/6300978111",
                    adSize: AdmobBannerSize.LARGE_BANNER)),
          ],
        );
      case 1:
        return MapboxMap(
            onMapClick: (p, c){print("ahoi");},
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
        );

      case 3:
        return Container(
          height: 1000,
          width: 600,
          color: cACCENT,
          child: WebView(
            initialUrl: 'https://maps.openrouteservice.org/',
            debuggingEnabled: true,
            onWebViewCreated: (WebViewController webViewController) {
              _wvcontroller.complete(webViewController);
            },
          ),
        );
    }


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
          /*markers.add(
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
          );*/
        }
      });
    } else {
      print(data);
    }
  }

  void _setStyle(gm.GoogleMapController controller) async {

    print("style set");

    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }



  MapboxMapController mapController;
  gm.GoogleMapController gmmapController;




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

      });
    });


  }


  // 1
  void searchNearby(double latitude, double longitude) async {
    setState(() {
      //markers.clear(); // 2
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


  /*BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-3940256099942544/6300978111",
    size: AdSize.smartBanner,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );*/


}





