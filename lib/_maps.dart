import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

static final CameraPosition _myLoc=
CameraPosition(target: LatLng(52, 10),);
