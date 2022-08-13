import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCategoryHome extends StatelessWidget {
  final String text;
  final String image;
  final void Function() onPress;


  ItemCategoryHome({required this.text, required this.image, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(17.0),
            color:  Colors.white,
          ),
       
        child: Row(

          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xd1000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Image.asset(image,height: 60,width: 60,),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: const Color(0xff7057f1),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
            ),

          ],
        ),
      ),
    );
  }
}


