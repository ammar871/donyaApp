import 'package:doniya/biussins_logic/bloc_auth/cubit/phone_auth_cubit.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/persentaiton/screens/home_screen/home_screen.dart';
import 'package:doniya/persentaiton/screens/login_screeen/componts/column_login_and_texts.dart';
import 'package:doniya/persentaiton/screens/login_screeen/componts/custom_button.dart';
import 'package:doniya/persentaiton/screens/login_screeen/componts/row_login_social.dart';
import 'package:doniya/persentaiton/screens/login_screeen/componts/row_phone_number.dart';
import 'package:doniya/providers/auth_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:easy_localization/easy_localization.dart';
class OtpScreen extends StatefulWidget {
 static String id="SignUpScreen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController controller = TextEditingController();
 late  String otpCode;
  @override
  Widget build(BuildContext context) {

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Image.asset("assets/images/logo_final.png",height: 150,width: 150,),
            SizedBox(height:10,),
            ColumnLoginAndTexts(text1:"OTP Verification".tr() ,
              text2: "Enter the OTP sent to +216XXXXXXXX".tr(),),
            const SizedBox(
              height: 30,
            ),
            Container(

              width: 300,
              color: Colors.transparent,
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                autoFocus: true,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                obscureText: false,
                textStyle: const TextStyle(
                    color: Colors.black, fontSize: 14, fontFamily: "home"),
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    borderWidth: 1,
                    activeColor: Color(0xFFE2E2E2),
                    inactiveColor: const Color(0xFFE2E2E2),
                    inactiveFillColor: Color(0xFFE2E2E2),
                    activeFillColor: const Color(0xFFE2E2E2),
                    selectedColor: const Color(0xFFE2E2E2),
                    selectedFillColor: Colors.white),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (code) {
                  otpCode = code;
                  print(otpCode);
                  // otpCode = code;
                },
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(onPress: (){
              AuthProviders.getInItRead(context).submitOTP(otpCode, context,onSuccsse: (){

                replacePage(page: HomeScreen(),context: context);
              },
                  onError: (){

                    print("weeeeeeeeeeeeeee");
                  });

              // showProgressIndicator(context);
              //
              // _login(context);

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
            const RowLoginSocial(),
            // _buildPhoneVerificationBloc(),
          ],
        ),
      ),
    );
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



  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }



  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(home);
        }

        if (state is ErrorOccurred) {
          //Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }
}
