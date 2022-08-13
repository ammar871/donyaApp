
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/commens.dart';
import '../../../helpers/conatans.dart';
import '../../../helpers/shard_prefrance.dart';
import '../home_screen/componts/custom_drop_dawn_widget.dart';

class ChangeLangScreen extends StatefulWidget {
  const ChangeLangScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'اختار اللغة',
          style: const TextStyle(
            fontFamily: 'pnuB',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Center(
            child: Image.asset("assets/images/logo_final.png",height: 150,width: 150,),
          ),
         SizedBox(height:30,),

         ContainerLang(title: 'العربية',onPress: (){

           context.setLocale(const Locale("ar", "AR"));
           shardPreferencesEditor.setlang("ar");
           Common.LANG = "ar";
           Common.LANGCode = "ar";
           Navigator.pushNamed(context, loginApi);
           getValue();
         },),

          SizedBox(height: 20,),
          ContainerLang(title: 'English',onPress: (){

            context.setLocale(const Locale("en", "US"));
            shardPreferencesEditor.setlang("en");
            Common.LANG = "en";
            Common.LANGCode = "en";
            Navigator.pushNamed(context, loginApi);
            getValue();
          },),

          SizedBox(height: 20,),
          ContainerLang(title: 'France',onPress: (){
            context.setLocale(const Locale("fr", "FR"));
            shardPreferencesEditor.setlang("fr");
            Common.LANG = "fr";
            Common.LANGCode = "fr";
            Navigator.pushNamed(context, loginApi);
            getValue();
          },),

          SizedBox(height: 20,)
        ],
      ),
    );
  }
  String? getValue()  {
    ShardPreferencesEditor _editor=ShardPreferencesEditor();
    String languageCode = Platform.localeName.split('_')[0];

    _editor.getlang().then((value) {
      if (value == "") {
        if (languageCode == "ar") {
          Common.LANG = langs[0];
        } else if (languageCode == "en") {
          Common.LANG = langs[2];
        } else if (languageCode == "fr") {
          Common.LANG =langs[1];
        }
      } else {
        if (value == "ar") {
          Common.LANG =langs[0];
        } else if (value == "en") {
          Common.LANG =langs[2];
        } else if (value == "fr") {
          Common.LANG =langs[1];
        }
      }
      print(Common.LANG);
    });
    return Common.LANG;
  }
}

class ContainerLang extends StatelessWidget {
final String title;
final void Function() onPress;


ContainerLang({required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: onPress,
    child:  Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 1)
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'pnUB',
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    ),);
  }
}
