import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/conatans.dart';
import '../../../bloc/profession_cubit/profession_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../widget/buttons.dart';
import '../../widget/fields_text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessionCubit, ProfessionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
            automaticallyImplyLeading: true,
            leading: IconButton(
                onPressed: () {
                  pop(context);
                  ProfessionCubit.get(context).userResponse = null;
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          body: BlocConsumer<ProfessionCubit, ProfessionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LoginSuccess) {
                printFunction("${state.responseProfessional.fullName}");

                Future.delayed(Duration.zero, () {
                  Navigator.pushNamed(context, home_prof);
                });
              } else if (state is LoginError) {
                Future.delayed(Duration.zero, () {
                  HelperFunction.slt.notifyUser(
                      color: Colors.red,
                      context: context,
                      message: state.message);
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
                          "أدخل رقم الهاتف".tr(),
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
                          height: 40,
                        ),
                        SizedBox(
                          height: 50,
                          child: ProfessionCubit.get(context).loadForget
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : CustomButton(
                                  onPress: () {
                                    if (isValidate(context)) {
                                      ProfessionCubit.get(context).forgetPass(
                                          phone: _controllerEmail.text.trim());
                                    }
                                  },
                                  text: "send".tr(),
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
                        ProfessionCubit.get(context).userResponse != null?   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: ProfessionCubit.get(context)
                                          .userResponse!
                                          .password!)).then((value){

                                    HelperFunction.slt.notifyUser(
                                        context: context,
                                        color: Colors.green,
                                        message: "تم النسخ".tr());
                                  });
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              ProfessionCubit.get(context).userResponse != null
                                  ? ProfessionCubit.get(context)
                                      .userResponse!
                                      .password!
                                  : "",
                              style: const TextStyle(
                                fontFamily: 'pnuB',
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ): SizedBox(
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
      },
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerEmail.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.grey,
          message: "أدخل رقم الهاتف".tr());
      return false;
    } else {
      return true;
    }
  }
}
