import 'dart:async';
import 'package:doniya/app-with-api/helpers/functions.dart';
import 'package:doniya/helpers/app_const.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/persentaiton/screens/adds/add_adds_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app-with-api/helpers/constants.dart';
import '../../../helpers/conatans.dart';

class Address {
  String? address;
  double? lat, lng;

  Address({this.address, this.lat, this.lng});
}

class SelectMapScreen extends StatefulWidget {
  @override
  State<SelectMapScreen> createState() => _SelectMapScreenState();
}

class _SelectMapScreenState extends State<SelectMapScreen> {
  var latitude;
  var longitude;

  String lable = "";
  String detailsAddress = "";

  double lat = 0.0;
  double lng = 0.0;
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllertext = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 14.4746,
  );

  void setInitialLocation() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 19,
      target: LatLng(locData.latitude ?? 33, locData.longitude ?? 29),
    );
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    printFunction("lable$lable");
    _controllertext.text = lable;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 270.0),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,
              buildingsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              onCameraMove: (object) {
                latitude = object.target.latitude;
                longitude = object.target.longitude;
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setInitialLocation();
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Icon(Icons.location_on_outlined),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 290,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.all(18),
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "اختر موقع",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        const Divider(),
                        TextField(
                          controller: _controllertext,
                          decoration: const InputDecoration(
                            hintText: 'تفاصيل العنوان',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 2, top: 11, right: 15),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          onChanged: (v) {},
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_controllertext.text.isNotEmpty) {
                        Address adress = Address(
                            lat: latitude,
                            lng: longitude,
                            address: _controllertext.text);
                        Navigator.pop(context, adress);
                      } else {
                        HelperFunction.slt.notifyUser(
                            message: "اكتب اسم العنوان ",
                            context: context,
                            color: Colors.black);
                      }
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      color: homeColor,
                      child: const Center(
                        child: Text(
                          "تآكيد الموقع",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
