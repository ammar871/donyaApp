import 'package:country_code_picker/country_code_picker.dart';
import 'package:doniya/app-with-api/bloc/auth_cubit/auth_cubit.dart';
import 'package:doniya/app-with-api/ui/auth_with_api_screens/otp_api_screen.dart';
import 'package:doniya/app-with-api/ui/auth_with_api_screens/sign_up_api_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui' as ui;
import '../../../helpers/commens.dart';
import '../../../helpers/conatans.dart';
import '../../../persentaiton/screens/login_screeen/componts/button_social.dart';
import '../../../persentaiton/screens/login_screeen/componts/custom_button.dart';
import '../../../persentaiton/screens/login_screeen/componts/custom_text_filed.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../privacy_screen/privacy_screen.dart';

class LoginApiScreen extends StatefulWidget {
  static String id = "LoginApiScreen";

  const LoginApiScreen({Key? key}) : super(key: key);

  @override
  State<LoginApiScreen> createState() => _LoginApiScreenState();
}

class _LoginApiScreenState extends State<LoginApiScreen> {
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        if (state is CheckUserAuthStateSuccess) {
          printFunction( "${state.status}" );

          if (state.status == 0) {
            Future.delayed( Duration.zero, () {

              printFunction( "${state.status}" );
              pushPage(
                  page: SignUpApiScreen(phone: controller.text), context: context);
            });
            //

          } else {
            Future.delayed(Duration.zero, () {
              printFunction( "${state.status}" );
              pushPage(
                  page: OtpApiScreen(phone: state.phone, code: state.code),
                  context: context);
            });
            //
          }
        }

        return Scaffold(
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
                Image.asset(
                  "assets/images/logo_final.png", height: 150, width: 150,),
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
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Row(
                        children: [

                          // Container(
                          //   width: 1.5,
                          //   margin: const EdgeInsets.symmetric(vertical: 5),
                          //   color: Colors.black.withOpacity(.3),
                          // ),
                          SizedBox(

                            child: CountryCodePicker(
                              padding: EdgeInsets.all(1),
                              onChanged: (CountryCode countryCode){

                                AuthCubit.get(context).countryCode=countryCode.toString();
                                print(countryCode.toString());
                              },
                              textStyle: TextStyle(color: Colors.white),
                              flagWidth: 30,
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: "AE",
                              // favorite: ['+39','FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,

                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ),
                          Expanded(
                            child: CustomTextFiled(
                                controller: controller,
                                hint: 'Please type your phone number'.tr()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                state is CheckUserAuthStateLoad
                    ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
                    :    CustomButton(onPress: () {
                  if (isValidate()) {
                    AuthCubit.get(context)
                        .checkUserName(phone:AuthCubit.get(context).countryCode+controller.text);
                  }

                  // showProgressIndicator(context);
                  // _register(context);

                }, text: "LOGIN".tr(),),
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
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                 AuthCubit.get(context).loadLoginGoogle?SizedBox(height: 40,width: 40,child: Center(
                   child: CircularProgressIndicator(
                     color: Colors.white,
                   ),
                 ),)  : ButtonSocial(icon: "assets/icons/google.svg", onPress: () {
                              AuthCubit.get(context)
                                  .loginWithGoogle(context: context);
                    },),
                    const SizedBox(width: 20,),
                    AuthCubit.get(context).loadFaceLogin?SizedBox(height: 40,width: 40,child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),):   ButtonSocial(icon: "assets/icons/face.svg", onPress: () {
                      print("gffffffffff");
                      AuthCubit.get(context)
                          .signInWithFacebook(context: context);
                    },),
                    const SizedBox(width: 20,),
                    ButtonSocial(icon: "assets/icons/twiter.svg", onPress: () {
                      print("twiter");
                    },)

                  ],
                ),

                const SizedBox(
                  height: 25,
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
      },
    );
  }
  bool isValidate() {
    if (controller.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل رقم الهاتف");
      return false;
    } else {
      return true;
    }
  }
  // Future<void> _register(BuildContext context) async {
  //   if (controller.text.isEmpty) {
  //     Navigator.pop(context);
  //     return;
  //   } else {
  //
  //     BlocProvider.of<PhoneAuthCubit>(context)
  //         .submitPhoneNumber(countryCode+controller.text);
  //   }
  // }

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