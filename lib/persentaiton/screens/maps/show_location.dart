import 'dart:async';

import 'package:doniya/helpers/app_const.dart';
import 'package:doniya/persentaiton/screens/maps/select_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:easy_localization/easy_localization.dart';
class ShowLocation extends StatefulWidget {
  final String address;
  final String nameAdress;

  ShowLocation(this.address, this.nameAdress);

  @override
  State<ShowLocation> createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static double _lat = 0.0;
  static double _lng = 0.0;
  static String? name;
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.nameAdress;
    if (widget.address != null) {
      _lat = double.parse(widget.address.split(",")[0]);
      _lng = double.parse(widget.address.split(",")[1]);

      print("wwwwww$_lat  $_lng");
    }
  }

  Marker marker = Marker(
    //  markerId: markerId,
    draggable: true,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

    position: LatLng(_lat, _lng),

    infoWindow: InfoWindow(title: name!, snippet: '*'),
    onTap: () {},
    markerId: MarkerId("Your Location".tr()),
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: {marker},
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onCameraIdle: () {},
    );
  }
}
