import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  double radius;

  bool isIcon;

  CustomFormField(
      {
        required this.headingText,
        required this.hintText,
        required this.obsecureText,
        required this.suffixIcon,
        required this.textInputType,
        required this.textInputAction,
        required this.controller,
        required this.maxLines,this.isIcon=false,
        this.radius=10
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          maxLines: maxLines,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: textInputType,

          obscureText: obsecureText,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon:isIcon?const Icon(Icons.search):null ,
              hintStyle: KTextStyle.textFieldHintStyle,
              border: InputBorder.none,
              suffixIcon: suffixIcon),
        ),
      ),
    );
  }
}

class KTextStyle {
  static const headerTextStyle = TextStyle(
      color: Color(0xffC8C8C8), fontSize: 28, fontWeight: FontWeight.w700);

  static const textFieldHeading =
  TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const textFieldHintStyle = TextStyle(
      color: Color(0xffC8C8C8),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "pnuB");
//
// static const authButtonTextStyle = TextStyle(
//     fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteshade);
}

class CustomFormField2 extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String?)? onSaved;
  final int maxLines;
  double radius;

  CustomFormField2(
      {Key? key,
        required this.headingText,
        this.radius=10,
        required this.hintText,
        required this.onSaved,
        required this.obsecureText,
        required this.suffixIcon,
        required this.textInputType,
        required this.textInputAction,
        required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextFormField(
          maxLines: maxLines,
          onSaved: onSaved,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          obscureText: obsecureText,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: KTextStyle.textFieldHintStyle,
              border: InputBorder.none,
              suffixIcon: suffixIcon),
        ),
      ),
    );
  }
}