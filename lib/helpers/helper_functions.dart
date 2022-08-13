// import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commens.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class HelperFunctions {
  static HelperFunctions slt = HelperFunctions();

  notifyUser({context, message, color, bool isNeedPop = false}) {


    final snackBar = SnackBar(

      backgroundColor: color,
      content:  Text(message,style: TextStyle(
          fontFamily: "pnuB"

      ),),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
 /* return  Flushbar(
      padding: const EdgeInsets.all(30),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black26,
      animationDuration: Duration(milliseconds: 400),
      leftBarIndicatorColor: color,
    )..show(context).whenComplete(() {
        if (isNeedPop) pop(context);
      });*/
  }
}


