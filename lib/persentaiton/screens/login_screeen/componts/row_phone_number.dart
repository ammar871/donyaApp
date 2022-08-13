import 'package:doniya/wedgits/text_widegt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'custom_text_filed.dart';

class RowPhoneNumber extends StatelessWidget {
  const RowPhoneNumber({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black.withOpacity(.3), width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: (){

              },
              child: TextWidget(
                  text: "+216",
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "bold"),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 1.5,
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.black.withOpacity(.3),
            ),
            CustomTextFiled(
                controller: controller,
                hint: 'Please type your phone number'.tr())
          ],
        ),
      ),
    );
  }
}