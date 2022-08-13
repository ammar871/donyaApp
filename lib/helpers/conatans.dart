import 'dart:ui';


import 'package:location/location.dart';


const homeColor= Color(0xff4567D5);
const secondColor= Color(0xffD1ECFB);




//screens

const login="/login";
const home="/home";
const langScreen="/change_lang";


const add_add_profession="/add_add_profession";
const my_adds_prof="/my_adds_prof";
const loginApi="/loginapi";
const home_prof="/home_prof";
const profession_splash="/profession_splash";
const perfession_login="/perfession_login";
const otpScreen="/otpScreen";
const subhome="/subhome";
const categoAdds="/categoAdds";
const add_adds_screen="/add_adds_screen";
const categMaintence="/categMaintence";
const categAuction="/categAuction";
const all_adds="/all_adds_screen";
const my_adds_screen="/my_adds_screen";
const map_screen="/map_screen";

// name Tables
const aucationHC="AuctionhC";
const aucationSC="AuctionSC";
const classifiedAdsSC="ClassifiedAdsSC";
const classifiedAdshC="ClassifiedAdshC";
const maintenanceSC="MaintenanceSC";
const maintenancehC="MaintenancehC";
// const MaintenanceSC="MaintenanceSC";



class Tables{
  static List<String> cAdds=[];
  static List<String> cMain=[];
  static List<String> cAuction=[];

  static List<String> cAddsSC=[];
  static List<String> cMainSC=[];
  static List<String> cAuctionSC=[];

}


late String currentLocal;
LocationData locData = LocationData.fromMap({});
getLocation() async {
  Location location =  Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locData = await location.getLocation();
  print(locData.latitude.toString() + " lat:");
}