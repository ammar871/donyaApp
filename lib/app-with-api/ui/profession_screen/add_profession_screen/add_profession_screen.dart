import 'package:country_picker/country_picker.dart';
import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';
import 'package:doniya/app-with-api/models/category_profession.dart';
import 'package:doniya/app-with-api/models/profession.dart';
import 'package:doniya/helpers/commens.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../helpers/conatans.dart';
import '../../../../persentaiton/screens/adds/add_adds_screen.dart';
import '../../../../wedgits/drop_dawon.dart';
import '../../../bloc/add_cubit/add_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';

class AddProfessionScreen extends StatefulWidget {
  final int status;
  final CategoryProfession prof;

  AddProfessionScreen({required this.status, required this.prof});

  @override
  State<AddProfessionScreen> createState() => _AddProfessionScreenState();
}

class _AddProfessionScreenState extends State<AddProfessionScreen> {
  XFile? image1;

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? usId;

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
      image1 = null;
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      // file = pickedFile!;
      image1 = pickedFile;

      AddCubit.get(context).uploadImage(image1);
    } catch (e) {
      print(e);
    }
  }

  var results;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddCubit.get(context).imagesString = [];
    ProfessionCubit.get(context).currentCategory = null;
    ProfessionCubit.get(context).currentCategory = ProfessionCubit.get(context)
        .categoryProfessions
        .firstWhere((element) => element.id == widget.prof.id,
            orElse: () => CategoryProfession());

    /* if (widget.status == 1) {
      ProfessionCubit.get(context).currentCategory =
          ProfessionCubit.get(context).categoryProfessions.firstWhere(
              (element) => element.id == widget.prof.categoryId!,
              orElse: () => CategoryProfession());

      widget.prof.isImage!
          ? AddCubit.get(context).imagesString =
              widget.prof.images!.split("#")
          : AddCubit.get(context).imagesString = [];

      lat = double.parse(widget.prof.lat!);
      lng = double.parse(widget.prof.lang!);
      _controllerAddress.text = widget.prof.address!;
      _controllerTitle.text = widget.prof.title!;
      _controllerAr.text = widget.prof.desc!;
      _controllerPhone.text = widget.prof.phone!;
      _controllerWhats.text = widget.prof.phoneWhats!;
      _controllerNameAdvster.text = widget.prof.advertiserName!;
      countryName = widget.prof.country!;

      // _controllerTitle.text=widget.prof.title!;
      // _controllerAr.text=widget.prof.desc!;
      // _controllerNameAdvster.text=widget.prof.advertiserName!;
      // _controllerWhats.text=widget.prof.phoneWhats!;
      // _controllerPhone.text=widget.prof.phone!;
      // _controllerAddress.text=widget.prof.desc!;
      // image1=widget.prof.images
    }*/

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
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: BlocConsumer<ProfessionCubit, ProfessionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 220,
                        child: CustomDropDownWidget(
                            currentValue:
                                ProfessionCubit.get(context).currentCategory,
                            selectCar: false,
                            colorBackRound: const Color(0xffF6F6F6),
                            textColor: Colors.black,
                            isTwoIcons: false,
                            iconColor: const Color(0xff515151),
                            icon2: Icons.add_box_outlined,
                            icon1: Icons.search,
                            list: ProfessionCubit.get(context)
                                .categoryProfessions,
                            onSelect: (value) {
                              ProfessionCubit.get(context)
                                  .changeValueDrop(value);
                            },
                            hint: "Select Category".tr()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 30,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
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
                                                                    .circular(
                                                                        8),
                                                            border:
                                                                Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            .4),
                                                                    width: 2)),
                                                        child: const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 50,
                                                        )),
                                              );
                                            } else {
                                              String file =
                                                  AddCubit.get(context)
                                                      .imagesString[index - 1];
                                              return ItemeImages(
                                                  image: file,
                                                  onPress: () {
                                                    AddCubit.get(context)
                                                        .deleteImage(
                                                            image: file);
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
                                              (BuildContext context,
                                                  int index) {
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
                                        hint: "أدخل اسم المهنة".tr(),
                                        controller: _controllerTitle,
                                        onSave: (value) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                        BorderRadius.circular(
                                                            5),
                                                    color: selectLang == 1
                                                        ? Colors.grey[300]
                                                        : Colors.white),
                                                child: Center(
                                                  child: Text(
                                                      "اضافة النص بالعربي",
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
                                                    width: 1,
                                                    color: Colors.black)),
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
                                                disabledBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5),
                                                hintText: "النص بالعربي",
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
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
                                                    width: 1,
                                                    color: Colors.black)),
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
                                                disabledBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5),
                                                hintText: "Text With English",
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextFormField(
                                        controlerresulte: 0,
                                        hint: "أدخل الاسم".tr(),
                                        controller: _controllerNameAdvster,
                                        onSave: (value) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextFormField(
                                        controller: _controllerPhone,
                                        controlerresulte: 0,
                                        keabord: TextInputType.number,
                                        hint: "رقم التلفون".tr(),
                                        onSave: (value) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextFormField(
                                        controller: _controllerWhats,
                                        keabord: TextInputType.number,
                                        controlerresulte: 0,
                                        hint: "أدخل رقم واتس".tr(),
                                        onSave: (value) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextFormField(
                                        controller: _controllerAddress,
                                        controlerresulte: 1,
                                        hint: "أدخل العنوان".tr(),
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
                                      child: ProfessionCubit.get(context)
                                                  .loadAddAdd ||
                                              ProfessionCubit.get(context)
                                                  .loadUpdate
                                          ? const SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          : MaterialButton(
                                              color: Colors.green,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 3),
                                              onPressed: () {
                                                printFunction(
                                                    _controllerTitle.text);

                                                if (isValidate()) {
                                                  // if (widget.status == 1) {
                                                  //   print("updateing");
                                                  //   if (AddCubit.get(context)
                                                  //           .imagesString
                                                  //           .length >
                                                  //       0) {
                                                  //     Profession addModelNew = Profession(
                                                  //         title: _controllerTitle
                                                  //             .text,
                                                  //         desc: _controllerAr
                                                  //             .text,
                                                  //         country: countryName,
                                                  //         images:
                                                  //             AddCubit.get(context)
                                                  //                 .imagesString
                                                  //                 .join("#"),
                                                  //         categoryId: widget
                                                  //             .prof.categoryId,
                                                  //         phone:
                                                  //             _controllerPhone
                                                  //                 .text,
                                                  //         isImage: true,
                                                  //         status: widget
                                                  //             .prof.status,
                                                  //         advertiserName:
                                                  //             _controllerNameAdvster
                                                  //                 .text,
                                                  //         phoneWhats:
                                                  //             _controllerWhats
                                                  //                 .text,
                                                  //         address:
                                                  //             _controllerAddress
                                                  //                 .text,
                                                  //         lat: lat.toString(),
                                                  //         id: widget.prof.id,
                                                  //         userId: widget
                                                  //             .prof.userId,
                                                  //         lang: lng.toString());
                                                  //     ProfessionCubit.get(context)
                                                  //         .updateAdd(
                                                  //             context: context,
                                                  //             addModel:
                                                  //                 addModelNew,
                                                  //             onSuccess: () {
                                                  //              Navigator.pop(context);
                                                  //
                                                  //             });
                                                  //   } else {
                                                  //     Profession addModelNew = Profession(
                                                  //         title:
                                                  //             _controllerTitle
                                                  //                 .text,
                                                  //         desc: _controllerAr
                                                  //             .text,
                                                  //         country: countryName,
                                                  //         images: "no",
                                                  //         categoryId: widget
                                                  //             .prof.categoryId,
                                                  //         phone:
                                                  //             _controllerPhone
                                                  //                 .text,
                                                  //         isImage: false,
                                                  //         status: widget
                                                  //             .prof.status,
                                                  //         advertiserName:
                                                  //             _controllerNameAdvster
                                                  //                 .text,
                                                  //         phoneWhats:
                                                  //             _controllerWhats
                                                  //                 .text,
                                                  //         address:
                                                  //             _controllerAddress
                                                  //                 .text,
                                                  //         lat: lat.toString(),
                                                  //         id: widget.prof.id,
                                                  //         userId: widget
                                                  //             .prof.userId,
                                                  //         lang: lng.toString());
                                                  //     ProfessionCubit.get(context)
                                                  //         .updateAdd(
                                                  //             addModel:
                                                  //                 addModelNew,
                                                  //             context: context,
                                                  //             onSuccess: () {
                                                  //               Navigator.pop(context);
                                                  //             });
                                                  //   }
                                                  // } else {
                                                  print("Unupdateing");
                                                  if (AddCubit.get(context)
                                                          .imagesString
                                                          .length >
                                                      0) {
                                                    ProfessionCubit.get(context)
                                                        .addAddProfession(
                                                            token: tokenFCM,
                                                            title: _controllerTitle
                                                                .text,
                                                            desc: _controllerAr
                                                                    .text
                                                                    .isEmpty
                                                                ? _controllerEng
                                                                    .text
                                                                : _controllerAr
                                                                    .text,
                                                            country:
                                                                countryName,
                                                            images: AddCubit
                                                                    .get(
                                                                        context)
                                                                .imagesString
                                                                .join("#"),
                                                            categoryId: ProfessionCubit
                                                                    .get(
                                                                        context)
                                                                .currentCategory!
                                                                .id,
                                                            phone:
                                                                _controllerPhone
                                                                    .text,
                                                            isImage: true,
                                                            status: "0",
                                                            nameAvertiser:
                                                                _controllerNameAdvster
                                                                    .text,
                                                            phoneWhats:
                                                                _controllerWhats
                                                                    .text,
                                                            address:
                                                                _controllerAddress
                                                                    .text,
                                                            lat: lat.toString(),
                                                            context: context,
                                                            onSuccess: () {
                                                              ProfessionCubit.get(
                                                                      context)
                                                                  .currentCategory = null;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            lang:
                                                                lng.toString());
                                                  } else {
                                                    ProfessionCubit.get(context)
                                                        .addAddProfession(
                                                            token: tokenFCM,
                                                            title: _controllerTitle
                                                                .text,
                                                            desc: _controllerAr.text
                                                                    .isEmpty
                                                                ? _controllerEng
                                                                    .text
                                                                : _controllerAr
                                                                    .text,
                                                            country:
                                                                countryName,
                                                            images: "no",
                                                            categoryId:
                                                                ProfessionCubit
                                                                        .get(
                                                                            context)
                                                                    .currentCategory!
                                                                    .id,
                                                            phone:
                                                                _controllerPhone
                                                                    .text,
                                                            isImage: false,
                                                            status: "0",
                                                            nameAvertiser:
                                                                _controllerNameAdvster
                                                                    .text,
                                                            phoneWhats:
                                                                _controllerWhats
                                                                    .text,
                                                            address:
                                                                _controllerAddress
                                                                    .text,
                                                            lat: lat.toString(),
                                                            context: context,
                                                            onSuccess: () {
                                                              ProfessionCubit.get(
                                                                      context)
                                                                  .currentCategory = null;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            lang:
                                                                lng.toString());
                                                  }
                                                }
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "نشـر".tr(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
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
              );
            },
          ),
        ));
  }

  bool isValidate() {
    if (ProfessionCubit.get(context).currentCategory == null) {
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
          color: Colors.black,
          context: context,
          message: "اكتب نص الاعلان".tr());
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black,
          context: context,
          message: "اكتب رقم الهاتف".tr());
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
