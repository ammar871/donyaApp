import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'conatans.dart';



void showLoadingDialog(BuildContext context,{color}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0.1),
      builder: (context) {
        return  LoadingDialog();
      });
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 10);
    Curve insetAnimationCurve = Curves.bounceIn;

    RoundedRectangleBorder _defaultDialogShape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)));

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,

      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: const SpinKitDoubleBounce(
          color: Colors.white,
          size: 70,

        ),
      ),
    );
  }
}
