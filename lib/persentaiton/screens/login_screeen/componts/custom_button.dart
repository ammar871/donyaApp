import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/wedgits/text_widegt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

final String text;
final void Function() onPress;

CustomButton({required this.text, required this.onPress});


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: homeColor.withOpacity(.5),
      height: 45,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
      onPressed: onPress,
      child: TextWidget(text: text,fontSize: 15,color: Colors.white,fontFamily: "light",),);
  }
}