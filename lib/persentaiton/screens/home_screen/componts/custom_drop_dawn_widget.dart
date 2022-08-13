import 'dart:io';

import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> langs = [
  'العربية 🇹🇳',
  '🇫🇷  Fr',
  '🇬🇧 Eng',
];


String? getValue()  {
  ShardPreferencesEditor _editor=ShardPreferencesEditor();
  String languageCode = Platform.localeName.split('_')[0];

  _editor.getlang().then((value) {
    if (value == "") {
      Common.LANG="";
      // if (languageCode == "ar") {
      //   Common.LANG = langs[0];
      // } else if (languageCode == "en") {
      //   Common.LANG = langs[2];
      // } else if (languageCode == "fr") {
      //   Common.LANG =langs[1];
      // }

      return ;
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
class CustomDropDawnWidget extends StatefulWidget {
  final Function(String) onCountChanged;

  CustomDropDawnWidget(this.onCountChanged);

  @override
  State<CustomDropDawnWidget> createState() => _CustomDropDawnWidgetState();
}

class _CustomDropDawnWidgetState extends State<CustomDropDawnWidget> {
  String? value;
  String? selectIndex;
  ShardPreferencesEditor editor = ShardPreferencesEditor();
  String? langValue ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  // final List<String> langs = [
  //   'العربية 🇹🇳',
  //   '🇫🇷  Fr',
  //   '🇬🇧 Eng',
  // ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      focusColor: Colors.white,
      value:Common.LANG,
      //value,

      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: langs.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(

          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'bold',
              fontSize: 15,
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }).toList(),
      icon:Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.black,
      ),
      underline: SizedBox(),
      hint: const Text("🇫🇷 FR",
          style: TextStyle(
            fontFamily: 'bold',
            fontSize: 15,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
          )),
      onChanged: (String? value) {
        setState(() {

          this.value = value;

          if (value == langs[0]) {
            selectIndex = "0";
          } else if (value == langs[1]) {
            selectIndex = "1";
          } else {
            selectIndex = "2";
          }
          widget.onCountChanged(selectIndex!);
          getValue();

        });
      },
    );
  }
}
