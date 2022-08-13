import 'dart:async';

import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/biussins_logic/bloc_auth/cubit/phone_auth_cubit.dart';
import 'package:doniya/helpers/app_const.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../app-with-api/helpers/functions.dart';
import 'dart:ui' as ui;

class Contriller extends StatefulWidget {
  const Contriller({Key? key}) : super(key: key);

  @override
  State<Contriller> createState() => _ContrillerState();
}

class _ContrillerState extends State<Contriller> {
  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();

  void navigationPage() {
    if (isRegistered()) {
      print("null");
      Navigator.of(context).pushReplacementNamed(home);
    } else if (Common.LANG == "") {
      Navigator.of(context).pushReplacementNamed(langScreen);
    } else {
      print("home");

      Navigator.of(context).pushReplacementNamed(loginApi);
    }

    //
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user == null) {
    //     print("null");
    //     Navigator.of(context).pushReplacementNamed(login);
    //   } else {
    //     print("home");
    //     Navigator.of(context).pushReplacementNamed(home);
    //   }
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("token$Common.LANG");

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // context.read<AddsProviders>().getSubCategoreisAdds();
      FirebaseMessaging.instance.getToken().then((value) {
        tokenFCM = value!;
        print("tokkkkkkkkkken:$tokenFCM");
      });
      // Add Your Code here.
    });

    startTime();
    _determinePosition();
    getLang();
    getValue();
  }

  getLang() async {
    print("lllllllllllll${Common.TYPE_ACCOUNT_DROP}");
    String currentLang = ui.window.locale.languageCode;
    await shardPreferencesEditor.getlang().then((value) {
      Common.LANGCode = value;
      print("llllllllll$value");
      if (value == "") {
        // shardPreferencesEditor.setlang(currentLang);
        // Common.LANGCode = currentLang;
        return;
      } else {
        if (value == "ar") {
          context.setLocale(const Locale("ar", "AR"));
        } else if (value == "en") {
          context.setLocale(const Locale("en", "US"));
        } else {
          context.setLocale(const Locale("fr", "FR"));
        }
      }
    });
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    AppConst.lattude = position.latitude;
    AppConst.longTiud = position.longitude;
    print("  My Location ${AppConst.lattude}\n ${AppConst.longTiud}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: homeColor,
        child: Center(
          child: Image.asset(
            "assets/images/logo_final.png",
            height: 200,
            width: 200,
          ),
        ),
      ),
      /* body: ListView(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/backround_login.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Image.asset("assets/images/logo.png"),
                ),)
              ],
            ),
          ],
        )*/
    );
  }
}
