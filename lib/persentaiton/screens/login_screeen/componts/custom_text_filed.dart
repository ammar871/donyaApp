import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  CustomTextFiled({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 220,
      child: Center(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'bold',
            fontSize: 14,

            color: Color(0xb2ffffff),
            fontWeight: FontWeight.w300,
          ),
          decoration:  InputDecoration(
              contentPadding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle:  const TextStyle(
                fontFamily: 'bold',
                fontSize: 14,

                color: Color(0xb2ffffff),
                fontWeight: FontWeight.w400,
              )),
        ),
      ),
    );
  }
}