import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/bloc/category_cubit/category_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/helpers/functions.dart';
import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:easy_localization/src/public_ext.dart';

import '../../../wedgits/drop_dawon.dart';

class AddAddsScreen extends StatefulWidget {
 final int status;

  AddAddsScreen({required this.status});

  @override
  State<AddAddsScreen> createState() => _AddAddsScreenState();
}

class _AddAddsScreenState extends State<AddAddsScreen> {
  XFile? image1;
  List<XFile>? imageFileList = [];
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? usId;
  CountryCode? codeWhats,codeNumberPhone;
  String codeCountryW="+971";
  String codeCountryPhone="+971";
  String? selcteType2;
  double lat = 0.0;
  double lng = 0.0;
  String countryName = "Select Country".tr();
  int selectLang = 1;
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerEng = TextEditingController();
  final TextEditingController _controllerAr = TextEditingController();
  final TextEditingController _controllerNameAdvster = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerWhats = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();


  _choseImage() async {
    try {
      imageFileList = null;
      final pickedFile = await _picker.pickMultiImage(

        // imageQuality: 5,
      );
      // file = pickedFile!;
      setState(() {

        imageFileList = pickedFile;
        if(imageFileList!.isNotEmpty){

          imageFileList!.forEach((element) {
            AddCubit.get(context).uploadMultiImages(element);
          });
        }




      });


    } catch (e) {
      print(e);
    }
  }

  var results;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageFileList = [];
    AddCubit.get(context).imagesString = [];
    CategoryCubit.get(context).currentCategory=null;
    CategoryCubit.get(context).subCategoryResponse=null;
    // getListCatego();
  }

  @override
  void dispose() {
    _controllerAr.dispose();
    _controllerEng.dispose();
    _controllerTitle.dispose();
    _controllerPhone.dispose();
    _controllerAddress.dispose();
    _controllerNameAdvster.dispose();
    _controllerWhats.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: homeColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              "اضافةالاعلان".tr(),
              style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "pnuB"),
            )),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<CategoryCubit, CategoryState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width:double.infinity,

                            child: CustomDropDownWidget(
                                currentValue:
                                    CategoryCubit.get(context).currentCategory,
                                selectCar: false,
                                colorBackRound: const Color(0xffF6F6F6),
                                textColor: Colors.black,
                                isTwoIcons: false,
                                iconColor: const Color(0xff515151),
                                icon2: Icons.add_box_outlined,
                                icon1: Icons.search,
                                list: CategoryCubit.get(context).categories,
                                onSelect: (value) {
                                  CategoryCubit.get(context)
                                      .subCategoryResponse = null;
                                  CategoryCubit.get(context).SubCategories = [];
                                  CategoryCubit.get(context)
                                      .changeValueDrop(value);
                                  CategoryCubit.get(context)
                                      .getSubCategoryByCatId(catId: value.id,cuntry: Common.COUNTRY_USER);
                                },
                                hint: "Select Category".tr()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CategoryCubit.get(context).loadSubCategories
                              ? const CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 3,
                                )
                              : Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                                  width:double.infinity,
                                  child: CustomDropDownWidgetSub(
                                      currentValue: CategoryCubit.get(context)
                                          .subCategoryResponse,
                                      selectCar: true,
                                      colorBackRound: const Color(0xffF6F6F6),
                                      textColor: Colors.black,
                                      isTwoIcons: false,
                                      iconColor: const Color(0xff515151),
                                      icon2: Icons.add_box_outlined,
                                      icon1: Icons.search,
                                      list: CategoryCubit.get(context)
                                          .SubCategories,
                                      onSelect: (value) {
                                        CategoryCubit.get(context)
                                            .changeValueDropSubCategoryResponse(
                                                value);
                                      },
                                      hint: "اختار القسم الفرعي".tr()),
                                ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AddCubit, AddState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            height: 140,
                            child: AddCubit.get(context).loadImage
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : Center(
                                    child: ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: AddCubit.get(context)
                                              .imagesString
                                              .length +
                                          1,
                                      itemBuilder: (_, int index) {
                                        if (index == 0) {
                                          return InkWell(
                                            onTap: () {
                                              if (AddCubit.get(context)
                                                      .imagesString
                                                      .length >=
                                                  5) {
                                                print("no");
                                              } else {
                                                _choseImage();
                                              }
                                            },
                                            child: AddCubit.get(context)
                                                        .imagesString
                                                        .length >=
                                                    5
                                                ? SizedBox()
                                                : Container(
                                                    width: 100,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .4),
                                                            width: 2)),
                                                    child: const Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 50,
                                                    )),
                                          );
                                        } else {
                                          String file = AddCubit.get(context)
                                              .imagesString[index - 1];
                                          return ItemeImages(
                                              image: file,
                                              onPress: () {
                                                AddCubit.get(context)
                                                    .deleteImage(image: file);
                                              },
                                              index: index - 1);
                                        }
                                        /* print("indexxxxxx${index}");


                              return

                                InkWell(
                                  onTap: (){
                                    print("dkdkd");
                                    _choseImage(image1);

                                  },
                                  child: ItemeImages(images:images ,index:index)) ;*/
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(width: 3);
                                      },
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: false,

                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) async {
                                  // print(country.name);

                                  setState(() {
                                    countryName = country.name;
                                  });
                                  // await  shardPreferencesEditor.getData(USER_Country);
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    countryName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "pnuB",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                    controlerresulte: 0,
                                    hint: "أدخل اسم الاعلان".tr(),
                                    controller: _controllerTitle,
                                    onSave: (value) {}),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectLang = 2;
                                              _controllerAr.text = "";
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: selectLang == 2
                                                    ? Colors.grey[300]
                                                    : Colors.white),
                                            child: Center(
                                              child: Text(
                                                "Add Text With English",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectLang = 1;
                                              _controllerEng.text = "";
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: selectLang == 1
                                                    ? Colors.grey[300]
                                                    : Colors.white),
                                            child: Center(
                                              child: Text("اضافة النص بالعربي",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                selectLang == 1
                                    ? Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: TextFormField(
                                          controller: _controllerAr,
                                          textAlign: TextAlign.right,

                                          keyboardType: TextInputType.text,
                                          maxLines: null,
                                          // onChanged: (value) {
                                          //   name=value;
                                          //   return null;
                                          // },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value.isEmpty)
                                                ? ''
                                                : null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0x99000000),
                                            height: 1.2,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                            hintText: "النص بالعربي",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: TextFormField(
                                          controller: _controllerEng,
                                          textAlign: TextAlign.start,
                                          // onSaved: (newValue) => textEng=newValue ,
                                          keyboardType: TextInputType.text,
                                          maxLines: null,
                                          // onChanged: (value) {
                                          //   textEng=value;
                                          //   return null;
                                          // },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value.isEmpty)
                                                ? ''
                                                : null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0x99000000),
                                            height: 1.2,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                            hintText: "Text With English",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    controlerresulte: 0,
                                    hint: "أدخل اسم المعلن".tr(),
                                    controller: _controllerNameAdvster,
                                    onSave: (value) {}),
                                const SizedBox(
                                  height: 10,
                                ),
                                Directionality(


                                  textDirection: ui.TextDirection.ltr,
                                  child: Row(
                                    children: [
                                      SizedBox(

                                        child: CountryCodePicker(
                                          padding: EdgeInsets.all(1),
                                          onChanged: (CountryCode countryCode){
                                            setState(() {
                                              codeNumberPhone=countryCode;
                                              codeCountryPhone=countryCode.dialCode.toString();
                                              print(countryCode.dialCode);
                                            });

                                          },
                                          textStyle: TextStyle(color: Colors.black),
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
                                        child: CustomTextFormField(
                                            controller: _controllerPhone,
                                            controlerresulte: 0,
                                            keabord: TextInputType.number,
                                            hint: "أدخل رقم المعلن".tr(),
                                            onSave: (value) {}),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Directionality(
                                  textDirection: ui.TextDirection.ltr,
                                  child: Row(
                                    children: [
                                      SizedBox(

                                        child: CountryCodePicker(
                                          padding: EdgeInsets.all(1),
                                          onChanged: (CountryCode countryCode){
                                                  setState(() {
                                                    codeWhats=countryCode;
                                                    codeCountryW=countryCode.dialCode.toString();
                                                    print(countryCode.dialCode);
                                                  });

                                          },
                                          textStyle: TextStyle(color: Colors.black),
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
                                        child: CustomTextFormField(
                                            controller: _controllerWhats,
                                            keabord: TextInputType.number,
                                            controlerresulte: 0,
                                            hint: "أدخل رقم واتس".tr(),
                                            onSave: (value) {}),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    controller: _controllerAddress,
                                    controlerresulte: 1,
                                    hint: "أدخل عنوان المعلن".tr(),
                                    onSave: (value) {
                                      // location = value;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: InkWell(
                                    onTap: () async {
                                      results = await Navigator.pushNamed(
                                          context, map_screen);

                                      if (results != null) {
                                        // You code goes here.

                                        setState(() {
                                          _controllerAddress.text =
                                              "${results.address}";
                                          lat = results.lat;
                                          lng = results.lng;

                                          // location == results.toString().split("/")[1];
                                          print("resulte${results.lat}");
                                        });
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "اختار موقع من الخريطة".tr(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "pnuB",
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 45,
                                  child: AddCubit.get(context).loadAddAdd
                                      ? const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      : MaterialButton(
                                          color: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          onPressed: () {
                                            printFunction(
                                                _controllerTitle.text);

                                            if (isValidate()) {
                                              if (AddCubit.get(context)
                                                      .imagesString
                                                      .length >
                                                  0) {
                                                AddCubit.get(context).addAdd(
                                                    homeCategory: CategoryCubit
                                                            .get(context)
                                                        .currentCategory!
                                                        .nameArbice,
                                                    subCategory: CategoryCubit
                                                        .get(context)
                                                        .subCategoryResponse!
                                                        .subCategory!.nameArbice,
                                                    title:
                                                        _controllerTitle.text,
                                                    desc: _controllerAr
                                                            .text.isEmpty
                                                        ? _controllerEng.text
                                                        : _controllerAr.text,
                                                    country: countryName,
                                                    images:
                                                        AddCubit.get(context)
                                                            .imagesString
                                                            .join("#"),
                                                    categoryId: CategoryCubit
                                                            .get(context)
                                                        .subCategoryResponse!
                                                        .subCategory!
                                                        .id!,
                                                    phone:
                                                    codeCountryPhone+ _controllerPhone.text,
                                                    isImage: true,
                                                    status: "0",
                                                    nameAvertiser:
                                                        _controllerNameAdvster
                                                            .text,
                                                    phoneWhats:
                                                        codeCountryW+_controllerWhats.text,
                                                    address:
                                                        _controllerAddress.text,
                                                    lat: lat.toString(),
                                                    context: context,
                                                    onSuccess: () {
                                                      CategoryCubit.get(context)
                                                              .subCategoryResponse =
                                                          null;
                                                      CategoryCubit.get(context)
                                                              .currentCategory =
                                                          null;
                                                    },
                                                    lang: lng.toString());
                                              } else {
                                                AddCubit.get(context).addAdd(
                                                    homeCategory: CategoryCubit
                                                        .get(context)
                                                        .currentCategory!
                                                        .nameArbice,
                                                    subCategory: CategoryCubit
                                                        .get(context)
                                                        .subCategoryResponse!
                                                        .subCategory!.nameArbice,
                                                    title: _controllerTitle
                                                        .text,
                                                    desc: _controllerAr
                                                            .text.isEmpty
                                                        ? _controllerEng.text
                                                        : _controllerAr.text,
                                                    country: countryName,
                                                    images: "no",
                                                    categoryId: CategoryCubit
                                                            .get(context)
                                                        .subCategoryResponse!
                                                        .subCategory!
                                                        .id!,
                                                    phone:codeCountryPhone+ _controllerPhone
                                                        .text,
                                                    isImage: false,
                                                    status: "0",
                                                    nameAvertiser:
                                                        _controllerNameAdvster
                                                            .text,
                                                    phoneWhats:
                                                    codeCountryW+_controllerWhats.text,
                                                    address:
                                                        _controllerAddress.text,
                                                    lat: lat.toString(),
                                                    context: context,
                                                    onSuccess: () {
                                                      CategoryCubit.get(context)
                                                              .subCategoryResponse =
                                                          null;
                                                      CategoryCubit.get(context)
                                                              .currentCategory =
                                                          null;
                                                    },
                                                    lang: lng.toString());
                                              }
                                            }


                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "نشـر".tr(),
                                              style: TextStyle(
                                                fontFamily: "pnuB",
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool isValidate() {
    if (CategoryCubit.get(context).currentCategory == null) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اختار القسم".tr());
      return false;
    } else if (CategoryCubit.get(context).subCategoryResponse == null) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اختار القسم".tr());
      return false;
    } else if (countryName == "Select Country".tr()) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اختار الدولة".tr());
      return false;
    } else if (_controllerTitle.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black,
          context: context,
          message: "اكتب عنوان الاعلان".tr());
      return false;
    } else if (_controllerAr.text.isEmpty && _controllerEng.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب نص الاعلان".tr());
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب رقم الهاتف".tr());
      return false;
    } else if (_controllerWhats.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب رقم واتس".tr());
      return false;
    } else if (_controllerAddress.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب العنوان".tr());
      return false;
    } else {
      return true;
    }
  }
}

class ItemeImages extends StatelessWidget {
  final String image;
  final int index;
  final void Function() onPress;

  ItemeImages(
      {required this.image, required this.index, required this.onPress});

  @override
  Widget build(BuildContext context) {
    // return  index > images.length ?  Container(
    //
    //     width: 100,
    //     height: 80,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         border: Border.all(
    //             color: Colors.grey.withOpacity(.4),width: 2)),
    //     child:  const Icon(
    //       Icons.add,
    //       size: 50,
    //     ))
    //
    //     :
    return Container(
        width: 100,
        height: 80,
        /* decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(.4),width: 2)),*/
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                baseUrlImages + image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onPress,
                child: Container(
                  margin: EdgeInsets.only(right: 2, top: 2),
                  height: 22,
                  width: 22,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(.6)),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final void Function(String) onSave;
  int? controlerresulte = 0;
  final keabord;
  TextEditingController? controller = TextEditingController();

  CustomTextFormField(
      {required this.hint,
      required this.onSave,
      this.controlerresulte,
      this.controller,
      this.keabord});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.start,
        onSaved: (newValue) => widget.onSave(newValue!),
        keyboardType:
            widget.keabord == null ? TextInputType.text : widget.keabord,
        // onChanged: (value) {
        //   setState(() {
        //     widget.onSave(value);
        //   });
        //   return null;
        // },
        // validator: (String? value) {
        //   return value!.isEmpty ? "" : null;
        // },
        style: const TextStyle(
          fontSize: 15,
          fontFamily: "pnuB",
          color: Color(0x99000000),
        ),
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          hintText: widget.hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}

class CustomDropDownWidget2 extends StatefulWidget {
  final List<SubCategoryResponse> list;
  final Function onSelect;
  final String hint;

  CustomDropDownWidget2(
      {required this.list, required this.onSelect, required this.hint});

  @override
  _CustomDroopDownWidgetState2 createState() => _CustomDroopDownWidgetState2();
}

class _CustomDroopDownWidgetState2 extends State<CustomDropDownWidget2> {
  String? currentValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Stack(
          children: [
            const Positioned(
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.green,
                  size: 35,
                )),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.hint,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0x99000000),
                            height: 2.2,
                          )),
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0x99000000),
                    height: 2.2,
                  ),
                  value: currentValue,
                  icon: SizedBox(),
                  iconSize: 25,
                  underline: SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });

                    widget.onSelect(value!);
                  },
                  items: widget.list.map<DropdownMenuItem<String>>(
                      (SubCategoryResponse value) {
                    return DropdownMenuItem<String>(
                      value: value.subCategory!.nameFrance,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            value.subCategory!.nameFrance!,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
