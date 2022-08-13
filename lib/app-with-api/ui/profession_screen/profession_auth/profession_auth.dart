import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';
import 'package:doniya/app-with-api/helpers/functions.dart';
import 'package:doniya/app-with-api/ui/profession_screen/profession_auth/forget_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/conatans.dart';
import '../../../../persentaiton/screens/adds/menu_adds_screen.dart';
import '../../../helpers/constants.dart';
import '../../widget/buttons.dart';
import '../../widget/fields_text.dart';

class ProfessionAuth extends StatefulWidget {
  @override
  State<ProfessionAuth> createState() => _ProfessionAuthState();
}

class _ProfessionAuthState extends State<ProfessionAuth> {
  final _controllerPass = TextEditingController();

  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  print("cccccccccccccccccccccc${  currentProf.id}");


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPass.dispose();
  }

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
          "login".tr(),
          style: const TextStyle(
            fontFamily: 'pnuB',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<ProfessionCubit, ProfessionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if (state is LoginSuccess) {
            printFunction( "${state.responseProfessional.fullName}" );

            Future.delayed( Duration.zero, () {

Navigator.pushNamed(context, home_prof);
            });

          }
          else if(state is LoginError){

            Future.delayed( Duration.zero, () {

              HelperFunction.slt.notifyUser(color: Colors.red,context: context, message: state.message);
            });

          }


          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
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
                      "الدخول لحسابك".tr(),
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
                    CustomFormField(
                      headingText: "Password",
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                      hintText: "رقم الهاتف".tr(),
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: _controllerEmail,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormField(
                      headingText: "Password",
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "الرقم السرى".tr(),
                      obsecureText: true,
                      suffixIcon: const SizedBox(),
                      controller: _controllerPass,
                    ),



                    InkWell(
                      onTap: (){
                        pushPage(context: context,page: ForgetPassword());
                      },
                      child: Row(children: [
                        Text(
                          "نسيت كلمة السر؟".tr(),
                          style: const TextStyle(
                            fontFamily: 'pnuB',
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      child:ProfessionCubit.get(context).loadLogin?Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),

                      ): CustomButton(
                        onPress: () {

                          if(isValidate(context)){

                            ProfessionCubit.get(context).loginUser(
                              email: _controllerEmail.text.trim(),
                              pass: _controllerPass.text.trim()
                            );
                          }


                        },
                        text: "login".tr(),
                        fontFamily: 'pnuB',
                        color: homeColor,
                        fontSize: 18,
                        height: 50,
                        textColor: Colors.white,
                        isBorder: true,
                        redius: 10,
                        isCustomColor: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "طلب حساب جديد".tr(),
                      style: const TextStyle(
                        fontFamily: 'pnuB',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //whats app
                        InkWell(
                          onTap: () {
                            openwhatsapp(
                               "+216 25 284 412",
                                context);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black45),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            launch(
                                ('tel://+216 25 284 412'));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.black45),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  bool isValidate(BuildContext context) {
   if (_controllerEmail.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الايميل".tr());
      return false;
    } else if (_controllerPass.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.grey,
          message: "أدخل الرقم السرى".tr());
      return false;
    } else {
      return true;
    }
  }
}
