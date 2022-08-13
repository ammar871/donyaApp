import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:doniya/app-with-api/bloc/category_cubit/category_cubit.dart';
import 'package:doniya/app-with-api/models/add_model.dart';
import 'package:doniya/app-with-api/models/category_model.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app-with-api/bloc/add_cubit/add_cubit.dart';
import '../../../app-with-api/helpers/constants.dart';
import '../../../app-with-api/helpers/functions.dart';
import '../../../helpers/conatans.dart';
import 'add_adds_screen.dart';

class UpdateAddScreen extends StatefulWidget {
  final AddModel model;

  UpdateAddScreen(this.model);

  @override
  State<UpdateAddScreen> createState() => _UpdateAddScreenState();
}

class _UpdateAddScreenState extends State<UpdateAddScreen> {
  final ImagePicker _picker = ImagePicker();

  String? usId;
  CategoryModel? categoryModel;
  String? selcteType2;
  CountryCode? codeWhats;
  double lat = 0.0;
  double lng = 0.0;
  String countryName = "Select Country".tr();
  int selectLang = 1;
  final TextEditingController _controllerTitle = TextEditingController();

  final TextEditingController _controllerAr = TextEditingController();
  final TextEditingController _controllerNameAdvster = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerWhats = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  XFile? image1;

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

    widget.model.isImage!
        ? AddCubit.get(context).imagesString = widget.model.images!.split("#")
        : AddCubit.get(context).imagesString = [];

    lat = double.parse(widget.model.lat!);
    lng = double.parse(widget.model.lang!);
    _controllerAddress.text = widget.model.address!;
    _controllerTitle.text = widget.model.title!;
    _controllerAr.text = widget.model.desc!;
    _controllerPhone.text = widget.model.phone!;
    _controllerWhats.text = widget.model.phoneWhats!;
    _controllerNameAdvster.text = widget.model.advertiserName!;
    countryName = widget.model.country!;
    codeWhats=CountryCode(name:widget.model.country,dialCode: "+971" );

    // getListCatego();
  }

  @override
  void dispose() {
    _controllerAr.dispose();

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
        automaticallyImplyLeading: true,
        title: Text(
          "Update",
          style: const TextStyle(
            fontFamily: 'bold',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black26, width: .8)),
              child: Text(
                widget.model.homeCategory!,
                style: const TextStyle(
                  fontFamily: 'punB',
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            spaceSized(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black26, width: .8)),
              child: Text(
                widget.model.subCategory!,
                style: const TextStyle(
                  fontFamily: 'punB',
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            spaceSized(),
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
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    AddCubit.get(context).imagesString.length +
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
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(.4),
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
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
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
                                return (value != null && value.isEmpty)
                                    ? ''
                                    : null;
                              },
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0x99000000),
                                height: 2.2,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                hintText: "النص بالعربي",
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
                          CustomTextFormField(
                              controller: _controllerPhone,
                              controlerresulte: 0,
                              keabord: TextInputType.number,
                              hint: "أدخل رقم المعلن".tr(),
                              onSave: (value) {}),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [

                              SizedBox(

                                child: CountryCodePicker(
                                  padding: EdgeInsets.all(1),
                                  onChanged: (CountryCode countryCode){
                                    setState(() {
                                      codeWhats=countryCode;
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                            height: 40,
                            child: AddCubit.get(context).loadUpdate
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
                                        horizontal: 30, vertical: 3),
                                    onPressed: () {
                                      printFunction(_controllerTitle.text);

                                      if (isValidate()) {
                                        if (AddCubit.get(context)
                                                .imagesString
                                                .length >
                                            0) {
                                          AddModel addModelNew = AddModel(
                                              homeCategory:
                                              widget.model.homeCategory,
                                              subCategory:
                                              widget.model.subCategory,
                                              title: _controllerTitle.text,
                                              desc: _controllerAr.text,
                                              country: countryName,
                                              images: AddCubit.get(context)
                                                  .imagesString
                                                  .join("#"),
                                              categoryId:
                                              widget.model.categoryId,
                                              phone: _controllerPhone.text,
                                              isImage: true,
                                              status: widget.model.status,
                                              advertiserName:
                                                  _controllerNameAdvster.text,
                                              phoneWhats:codeWhats!.dialCode! + _controllerWhats.text,
                                              address: _controllerAddress.text,
                                              lat: lat.toString(),
                                              id: widget.model.id,
                                              userId: widget.model.userId,
                                              lang: lng.toString());
                                          AddCubit.get(context).updateAdd(
                                            context: context,
                                              addModel: addModelNew,
                                              onSuccess: () {

                                              });
                                        } else {
                                          AddModel addModelNew = AddModel(
                                              homeCategory:
                                                  widget.model.homeCategory,
                                              subCategory:
                                                  widget.model.subCategory,
                                              title: _controllerTitle.text,
                                              desc: _controllerAr.text,
                                              country: countryName,
                                              images: "no",
                                              categoryId:
                                                 widget.model.categoryId,
                                              phone: _controllerPhone.text,
                                              isImage: false,
                                              status: widget.model.status,
                                              advertiserName:
                                                  _controllerNameAdvster.text,
                                              phoneWhats:codeWhats!.dialCode!+ _controllerWhats.text,
                                              address: _controllerAddress.text,
                                              lat: lat.toString(),
                                              id: widget.model.id,
                                              userId: widget.model.userId,
                                              lang: lng.toString());
                                          AddCubit.get(context).updateAdd(
                                              addModel: addModelNew,
                                              context: context,
                                              onSuccess: () {
                                                // Navigator.pop(context);
                                              });
                                        }
                                      }

                                      // _key.currentState!.validate();
                                      // if (_key.currentState!.validate()&& countryName!="Select Country".tr()) {
                                      //   _key.currentState!.save();
                                      //   if (AddCubit.get(context).imagesString.length > 0) {
                                      //     AddCubit.get(context).addAdd(
                                      //
                                      //         title: title!,
                                      //         desc: _controllerAr.text,
                                      //         country: countryName,
                                      //         images: images,
                                      //         textEnglish: "${_controllerEng.text}",
                                      //         phoneWhat: "${phoneWahts!}",
                                      //         location: _controller.text,
                                      //         phone: phone!,
                                      //         context: context,
                                      //         isImages: true,
                                      //         status: "2",
                                      //         table: widget.fieldHome!);
                                      //   } else {
                                      //     context.read<AddsProviders>().addAdds(
                                      //         userId: usId!,
                                      //         typeId: selcteType2!,
                                      //         name: name!,
                                      //         title: title!,
                                      //         desc: _controllerAr.text,
                                      //         images: images,
                                      //         country: countryName,
                                      //         textEnglish: "${_controllerEng.text}",
                                      //         phoneWhat: "${phoneWahts!}",
                                      //         location: _controller.text,
                                      //         phone: phone!,
                                      //         context: context,
                                      //         isImages: false,
                                      //         status: "2",
                                      //         table: widget.fieldHome!);
                                      //   }
                                      // } else {
                                      //
                                      //   print("no");
                                      // }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "تعديل".tr(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
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
      )),
    );
  }

  bool isValidate() {
    if (countryName == "Select Country".tr()) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اختار الدولة");
      return false;
    } else if (_controllerTitle.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black,
          context: context,
          message: " اكتب عنوان الاعلان");
      return false;
    } else if (_controllerAr.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب نص الاعلان");
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب رقم الهاتف");
      return false;
    } else if (_controllerWhats.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "ااكتب رقم واتس");
      return false;
    } else if (_controllerAddress.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          color: Colors.black, context: context, message: "اكتب العنوان");
      return false;
    } else {
      return true;
    }
  }
}

class spaceSized extends StatelessWidget {
  const spaceSized({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}
