import 'package:country_code_picker/country_code_picker.dart';
import 'package:doniya/app-with-api/ui/auth_with_api_screens/otp_api_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/conatans.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../helpers/functions.dart';
import '../widget/buttons.dart';
import '../widget/fields_text.dart';
import '../widget/texts.dart';

class SignUpApiScreen extends StatefulWidget {
  final String phone;

  const SignUpApiScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<SignUpApiScreen> createState() => _SignUpApiScreenState();
}

class _SignUpApiScreenState extends State<SignUpApiScreen> {
  final _key = GlobalKey<FormState>();

  final _controllerPhone = TextEditingController();

  final _controllerEmail = TextEditingController();

  final _controllerFullName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text = widget.phone;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {

        if (state is ValidateAuthStateError) {
          Future.delayed(Duration.zero, () {
            HelperFunction.slt.notifyUser(
                color: Colors.grey, message: state.error, context: context);
          });
        }

        if (state is RegisterAuthStateSuccess) {
          Future.delayed(Duration.zero, () {
            pushPage(
                context: context,
                page: OtpApiScreen(code: state.code, phone: state.userName));
          });
        }

        return Scaffold(
          backgroundColor: homeColor,
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
          body: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/logo_final.png", height: 150, width: 150,),
                    const SizedBox(
                      height: 20,
                    ),

                    CustomText(

                        family: "pnuR",
                        size: 18,
                        text:
                        "مرحبا".tr(),
                        textColor: Colors.white,
                        weight: FontWeight.w300,
                        align: TextAlign.start),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFormField(
                      headingText: "Email",
                      hintText: "الاسم بالكامل".tr(),
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: _controllerFullName,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormField(
                      headingText: "Password",
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "البريد الالكترونى".tr(),
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: _controllerEmail,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [

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
                          child: CustomFormField(
                            headingText: "Password",
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                            hintText: "رقم التلفون".tr(),
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: _controllerPhone,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CustomFormField2(
                    //   headingText: "Password",
                    //   maxLines: 1,
                    //   textInputAction: TextInputAction.done,
                    //   textInputType: TextInputType.text,
                    //   hintText: "كلمـة المرور",
                    //   obsecureText: true,
                    //   suffixIcon: IconButton(
                    //       icon: const Icon(Icons.visibility), onPressed: () {}),
                    //   onSaved: (value) {},
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CustomFormField2(
                    //   headingText: "Password",
                    //   maxLines: 1,
                    //   textInputAction: TextInputAction.done,
                    //   textInputType: TextInputType.text,
                    //   hintText: "اعادة كلمـة المرور",
                    //   obsecureText: true,
                    //   suffixIcon: IconButton(
                    //       icon: const Icon(Icons.visibility), onPressed: () {}),
                    //   onSaved: (value) {},
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Checkbox(
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    color: Colors.white, width: 2)),
                            checkColor: Colors.white,
                            activeColor: homeColor,
                            value: AuthCubit.get(context).isChecked,
                            onChanged: (value) {
                              AuthCubit.get(context).changeCheckBox(value!);
                            },
                          ),
                        ),
                         Text(
                          "أوافق علي الشروط والأحكام".tr(),
                          style: TextStyle(
                              color: Colors.white, fontFamily: "pnuL"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    state is ValidateAuthStateLoad
                        ? const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                        : CustomButton3(
                        text: "انشاء حساب جديد".tr(),
                        fontFamily: "PNUB",
                        onPress: () {
                          if (isValidate(context)) {
                            AuthCubit.get(context).validateUser(
                                fullName: _controllerFullName.text.trim(),
                                email: _controllerEmail.text.trim(),
                                username: AuthCubit.get(context).countryCode+_controllerPhone.text);
                          }
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 60),
                    const SizedBox(
                      height: 35,
                    ),
                    // const CustomText(
                    //     family: "pnuB",
                    //     size: 15,
                    //     text: "تخطى والاستمرار كضيف",
                    //     textColor: Colors.white,
                    //     weight: FontWeight.w300,
                    //     align: TextAlign.center),
                    // const SizedBox(
                    //   height: 35,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل رقم الهاتف");
      return false;
    } else if (_controllerFullName.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الاسم كاملا");
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الايميل");
      return false;
    } else if (!AuthCubit.get(context).isChecked) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.grey,
          message: "يجب الموافقة علي سياسة الخصوصية");
      return false;
    } else {
      return true;
    }
  }
}
