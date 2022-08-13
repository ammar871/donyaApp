import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/helpers/functions.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/conatans.dart';
import '../widget/buttons.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  ShardPreferencesEditor editor = ShardPreferencesEditor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      // floatingActionButton: FloatingActionButton.small(
      //   backgroundColor: Colors.green,
      //   child: Icon(
      //     Icons.refresh,
      //     color: Colors.white,
      //   ),
      //   elevation: 12,
      //   onPressed: () {
      //
      //   },
      // ),
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Maintenance".tr(),
          style: const TextStyle(
            fontFamily: 'pnuB',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/logo_final.png",
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "اختار نوع الحساب".tr(),
              style: const TextStyle(
                fontFamily: 'pnuB',
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 60,
            ),
            CustomButton3(
                text: "طالب خدمة".tr(),
                fontFamily: "pnuB",
                onPress: () {
                  saveData("طالب خدمة", "type");
                  Common.TYPE_ACCOUNT_DROP="طالب خدمة";
                  editor.setData("user", "type").then((value) {
                    Navigator.of(context).pushNamed(my_adds_prof);
                  });
                },
                redius: 0,
                color: Colors.white,
                textColor: homeColor,
                fontSize: 22,
                height: 60),
            SizedBox(
              height: 20,
            ),
            CustomButton3(
                text: "صاحب مهنة".tr(),
                fontFamily: "pnuB",
                onPress: () {
                  saveData("صاحب مهنة", "type");
                  Common.TYPE_ACCOUNT_DROP="صاحب مهنة";
                  editor.setData("prof", "type").then((value) {
                    if(currentProf.id!=null){
                      Navigator.of(context).pushNamed(home_prof);
                    }else{
                      Navigator.of(context).pushNamed(perfession_login);
                    }

                  });

                  // if (isValidate(context)) {
                  //   AuthCubit.get(context).validateUser(
                  //       fullName: _controllerFullName.text.trim(),
                  //       email: _controllerEmail.text.trim(),
                  //       username: _controllerPhone.text);
                  // }
                },
                redius: 0,
                color: Colors.white,
                textColor: homeColor,
                fontSize: 22,
                height: 60),
          ],
        ),
      ),
    );
  }
}

List<String> typeAccounts = ["صاحب مهنة".tr(), "طالب خدمة".tr()];
