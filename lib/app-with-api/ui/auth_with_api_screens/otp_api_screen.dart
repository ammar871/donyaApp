import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/persentaiton/screens/home_screen/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../helpers/commens.dart';
import '../../../persentaiton/screens/login_screeen/componts/custom_button.dart';
import '../../../wedgits/text_widegt.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../widget/texts.dart';
import 'dart:ui' as ui;
class OtpApiScreen extends StatelessWidget {


  final String code, phone;

  OtpApiScreen({Key? key, required this.code, required this.phone})
    ;

  String newCode = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {


        if(state is LoginAuthStateSuccess){

          Future.delayed(Duration.zero,(){
            replacePage(context: context,page: const HomeScreen());
          });
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: homeColor,
            title: CustomText(
                family: "pnuB",
                size: 25,
                text: "انشاء حساب جديد".tr(),
                textColor: Colors.white,
                weight: FontWeight.bold,
                align: TextAlign.start),
          ),
          backgroundColor: homeColor,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    // SizedBox(
                    //     width: double.infinity,
                    //     height: MediaQuery.of(context).size.height * .35,
                    //     child: ImageAndLogo(
                    //         rightMargen: 30,
                    //         fontSize: 45,
                    //         title2: 'الهاتف'.tr(),
                    //         title1: 'تأكيد رقم'.tr(),
                    //         image: "assets/images/back_login_e.png")),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/logo_final.png", height: 150, width: 150,),
                    const SizedBox(
                      height: 20,
                    ),


                    TextWidget(
                      text: "ادخل رمز التحقق المرسل على جوالك".tr(),
                      fontSize: 16,

                      color: Colors.white, fontFamily: 'punM',
             align: TextAlign.center,

                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(

                      text: code,
                      fontSize: 16,

                      color: Colors.white, fontFamily: '',
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    // todo :

                    SizedBox(
                      width: 200,
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          textStyle: const TextStyle(color: Colors.black),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.toString().length < 3) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(9),
                            fieldHeight: 50,
                            fieldWidth: 35,
                            inactiveColor: const Color(0xFFE2E2E2),
                            inactiveFillColor: const Color(0xFFE2E2E2),
                            borderWidth: 1,
                            selectedFillColor: const Color(0xFFE2E2E2),
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            newCode = v;
                            printFunction(newCode);
                          },
                          onChanged: (value) {
                            printFunction(value);
                          },
                          beforeTextPaste: (text) {
                            printFunction("Allowing to paste $text");
                            return true;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    state is LoginAuthStateLoad
                        ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),


                      child:  CustomButton(onPress: () {

                        if(newCode == code){
                          AuthCubit.get(context).loginUser(userName: phone, code: newCode);

                        }else{
                          HelperFunction.slt.notifyUser(context: context,
                              color: Colors.grey,message: "الكود غير صحيح");
                        }
                        // showProgressIndicator(context);
                        // _register(context);

                      }, text: "LOGIN",),
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
