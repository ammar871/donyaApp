import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String fontFamily;
var align;

  TextWidget({required this.text, required this.fontSize, required this.color,required this.fontFamily,this.align=TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,

      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
        height: 1.1333333333333333,
      ),
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      textAlign: align,
    );
  }
}