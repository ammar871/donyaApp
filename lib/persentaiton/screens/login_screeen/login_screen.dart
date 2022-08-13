
import 'package:country_picker/country_picker.dart';
import 'package:doniya/biussins_logic/bloc_auth/cubit/phone_auth_cubit.dart';
import 'package:doniya/firebase_reposetory/firebase_auth/firebase_auth.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/persentaiton/screens/otp_screen/otp_screen.dart';
import 'package:doniya/providers/auth_providers.dart';

import 'package:doniya/wedgits/text_widegt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../app-with-api/helpers/functions.dart';
import '../../../app-with-api/ui/privacy_screen/privacy_screen.dart';
import 'componts/button_social.dart';
import 'componts/column_login_and_texts.dart';
import 'componts/custom_button.dart';
import 'componts/custom_text_filed.dart';
import 'componts/row_login_social.dart';
import 'componts/row_phone_number.dart';
import 'package:easy_localization/easy_localization.dart';
class LoginScreen extends StatefulWidget {
  static String id="LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  Country? countrySelected;
   String? phoneNumber;
  String countryCode = "+20";

  final _auth =  FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_auth.currentUser!=null){

      Navigator.of(context).pushReplacementNamed(home);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return   Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: homeColor,
        title: Text(
          'Welcome To'.tr(),
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 42,
            color: const Color(0xfff2f3f6),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Image.asset("assets/images/logo_final.png",height: 150,width: 150,),
            SizedBox(height: 50,),


                      Container(
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

                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      countrySelected = country;
                                      countryCode = "+${country.phoneCode}";
                                      setState(() {});
                                      print(countrySelected!.name);
                                    },
                                  );

                                },
                                child: TextWidget(
                                    text: countryCode,
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
                      ),
                          const SizedBox(
                            height: 30,
                          ),
                           CustomButton(onPress: (){
                        if(controller.text.isNotEmpty){
                          AuthProviders.getInItRead(context).submitPhoneNumber(
                              context, countryCode+controller.text,
                              onSuccss: () {
                                pushPage(context: context,page: OtpScreen() );

                              });
                        }

                             // showProgressIndicator(context);
                             // _register(context);

                           },text: "LOGIN".tr(),),
                          const SizedBox(
                            height: 25,
                          ),
                           Text(
                            'or login with'.tr(),
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: Color(0xffffffff),
                              height: 1.2142857142857142,
                            ),
                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ButtonSocial(icon: "assets/icons/google.svg",onPress: (){
                            AuthProviders.getInItRead(context).loginWithGoogle(context: context
                            ,success: (){
                                  Navigator.of(context).pushReplacementNamed(home);
                                },onError: (){

                                });
                            // showProgressIndicator(context);
                            // BlocProvider.of<PhoneAuthCubit>(context)
                            //     .loginWithGoogle();
                          },),
                          const SizedBox(width: 20,),
                          ButtonSocial(icon: "assets/icons/face.svg",onPress: (){

                            print("gffffffffff");
                           AuthProviders.getInItRead(context).signInWithFacebook(
                             onError: (){},
                             context: context,
                             onSuccess: (){
                               print("shhhhhhhhhhhh");
                               Navigator.of(context).pushReplacementNamed(home);
                             }
                           );
                          },),
                          const SizedBox(width: 20,),
                          ButtonSocial(icon: "assets/icons/twiter.svg",onPress: (){
                            print("twiter");
                          },)

                        ],
                      ),

            TextButton(onPressed: (){

              pushPage(page: PrivacyPolicyScreen(
                Common.LANGCode == "ar"
                    ? 0
                    : (Common.LANGCode == "en"
                    ? 1
                    : 2),

              ),context: context);

            }, child:
            Text(
              'privacy'.tr(),

              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'pnuB',
                fontSize: 15,
                color: const Color(0xfff2f3f6),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),)
                          // _buildPhoneNumberSubmitedBloc()
          ],
        ),
      ),
      // body: ListView(
      //   children: [
      //     Stack(
      //       children: [
      //         // Image.asset(
      //         //   "assets/images/backround_login.png",
      //         //   height: MediaQuery.of(context).size.height,
      //         //   width: MediaQuery.of(context).size.width,
      //         //   fit: BoxFit.cover,
      //         // ),
      //         Positioned(
      //           bottom: 0,
      //           left: 0,
      //           right: 0,
      //           child: Container(
      //             width: double.infinity,
      //             height: MediaQuery.of(context).size.height * .5,
      //             color: const Color(0xff078DE8).withOpacity(.15),
      //           ),
      //         ),
      //         Positioned(
      //           top: MediaQuery.of(context).size.height * 0.1,
      //           left: 0,
      //           right: 0,
      //           child: Column(
      //             children: [
      //              ColumnLoginAndTexts(text1:"Entre Your Phone Number " ,text2: "we will send you verification  code",),
      //               const SizedBox(
      //                 height: 30,
      //               ),
      //           Container(
      //             height: 50,
      //             width: double.infinity,
      //             padding: const EdgeInsets.all(5),
      //             margin: const EdgeInsets.symmetric(horizontal: 30),
      //             decoration: BoxDecoration(
      //                 border: Border.all(
      //                     color: Colors.black.withOpacity(.3), width: 1),
      //                 borderRadius: BorderRadius.circular(8)),
      //             child: Center(
      //               child: Row(
      //                 children: [
      //                   InkWell(
      //                     onTap: (){
      //
      //                       showCountryPicker(
      //                         context: context,
      //                         showPhoneCode: true,
      //                         // optional. Shows phone code before the country name.
      //                         onSelect: (Country country) {
      //                           countrySelected = country;
      //                           countryCode = "+${country.phoneCode}";
      //                           setState(() {});
      //                           print(countrySelected!.name);
      //                         },
      //                       );
      //
      //                     },
      //                     child: TextWidget(
      //                         text: countryCode,
      //                         fontSize: 18,
      //                         color: Colors.white,
      //                         fontFamily: "bold"),
      //                   ),
      //                   const SizedBox(
      //                     width: 5,
      //                   ),
      //                   Container(
      //                     width: 1.5,
      //                     margin: const EdgeInsets.symmetric(vertical: 5),
      //                     color: Colors.black.withOpacity(.3),
      //                   ),
      //                   CustomTextFiled(
      //                       controller: controller,
      //                       hint: 'Please type your phone number')
      //                 ],
      //               ),
      //             ),
      //           ),
      //               const SizedBox(
      //                 height: 30,
      //               ),
      //                CustomButton(onPress: (){
      //                  showProgressIndicator(context);
      //                  _register(context);
      //
      //                },text: "LOGIN",),
      //               const SizedBox(
      //                 height: 25,
      //               ),
      //               const Text(
      //                 'or login with',
      //                 style: TextStyle(
      //                   fontFamily: 'bold',
      //                   fontSize: 14,
      //                   color: Color(0xffffffff),
      //                   height: 1.2142857142857142,
      //                 ),
      //                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      //                 textAlign: TextAlign.center,
      //               ),
      //               const SizedBox(
      //                 height: 25,
      //               ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               ButtonSocial(icon: "assets/icons/google.svg",onPress: (){
      //                 showProgressIndicator(context);
      //                 BlocProvider.of<PhoneAuthCubit>(context)
      //                     .loginWithGoogle();
      //               },),
      //               const SizedBox(width: 20,),
      //               ButtonSocial(icon: "assets/icons/face.svg",onPress: (){
      //                 print("face");
      //               },),
      //               const SizedBox(width: 20,),
      //               ButtonSocial(icon: "assets/icons/twiter.svg",onPress: (){
      //                 print("twiter");
      //               },)
      //
      //             ],
      //           ),
      //               _buildPhoneNumberSubmitedBloc()
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // )
    );
  }
  Future<void> _register(BuildContext context) async {
    if (controller.text.isEmpty) {
      Navigator.pop(context);
      return;
    } else {

      BlocProvider.of<PhoneAuthCubit>(context)
          .submitPhoneNumber(countryCode+controller.text);
    }
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

 /* Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmited) {
          print("succsse");
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(otpScreen, arguments: controller.text);
        }
        if (state is SucessLoginGoogle) {
          print("succsseشششششششش");
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(home);
        }

        if (state is ErrorOccurred) {
          print("succsse");
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }*/
}













