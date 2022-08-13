import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/wedgits/text_widegt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
class ColumnLoginAndTexts extends StatelessWidget {
  final String text1;
  final String text2;

  ColumnLoginAndTexts({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Image.asset("assets/images/logo.png"),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          TextWidget(
            text: 'Find all your needs here !'.tr(),
            color: homeColor,
            fontSize: 15,
            fontFamily: 'bold',
          ),
          const SizedBox(
            height: 15,
          ),

          TextWidget(
            text: text1,
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'bold',
          ),
          TextWidget(
            text: text2,
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'light',
          ),
        ],
      ),
    );
  }
}