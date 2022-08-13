import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common {

  static String userId="";
static String LANG="";
  static String LANGCode="";

  static String COUNTRY_USER="";
  static String TYPE_ACCOUNT="";

  static String TYPE_ACCOUNT_DROP="";



}

pageRout(BuildContext context,Widget page){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pop(context) {
  Navigator.of(context).pop();
}



replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}