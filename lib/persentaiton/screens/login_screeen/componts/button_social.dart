import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonSocial extends StatelessWidget {
  final String icon;
  final void Function() onPress;

  ButtonSocial({required this.icon, required this.onPress});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration
          (
            color: Colors.white,
            shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(10),
        child: Center(child: SvgPicture.asset(icon,height: 25,width: 25,)),
      ),
    );
  }
}