import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/bloc/category_cubit/category_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:doniya/persentaiton/screens/all_adds/all_adds_screen.dart';
import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import 'package:doniya/persentaiton/screens/adds/my_adds_screen.dart';
import 'package:doniya/persentaiton/screens/search_screen/search_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_adds_screen.dart';

class CategoriesAdds extends StatefulWidget {
  static String id = "/CategoriesAdds";

  @override
  State<CategoriesAdds> createState() => _CategoriesAddsState();
}

class _CategoriesAddsState extends State<CategoriesAdds> {
  String? subValue;
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  TextEditingController controller = TextEditingController();
  String country = "Select Country".tr();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit.get(context).getCategories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  /*
  *
  *  bar: Common.LANGCode == "ar"
                                                ? categoryModel.nameArbice!
                                                : (Common.LANGCode == "en"
                                                    ? "${categoryModel.nameEnglish}"
                                                    : "${categoryModel.nameFrance}"),
                                            name: "${categoryModel.id}",
                                            nameCategory:
                                                categoryModel.nameArbice!,
                                            field: "adds"
  *
  * */

  @override
  Widget build(BuildContext context) {
    // CollectionReference users =
    //     FirebaseFirestore.instance.collection(classifiedAdshC);
    return Scaffold(
      backgroundColor: homeColor,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        elevation: 12,
        onPressed: () {
          AddCubit.get(context).getAllAdds();
          CategoryCubit.get(context).getCategories();
        },
      ),
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Classified ads'.tr(),
          style: const TextStyle(
            fontFamily: 'bold',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ContainerSearch(controller, () {
                  pageRout(
                      context,
                      SearchScreen(
                          nameTable: "adds", textSearch: controller.text));
                }, () {
                  pageRout(
                      context,
                      SearchScreen(
                          nameTable: "adds", textSearch: controller.text));
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    // ContainerSearch(controller,(){
                    //   pageRout(context, SearchScreen(nameTable: "adds",textSearch:controller.text));
                    // }),
                    const SizedBox(
                      height: 40,
                    ),
                    CategoryCubit.get(context).loadCategories
                        ? Container(
                          child: Center(
                              child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 3),
                            )),
                        )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                            CategoryCubit.get(context).categories.length,
                            itemBuilder: (_, index) {
                              CategoryModel categoryModel =
                                  CategoryCubit.get(context).categories[index];
                              return InkWell(
                                onTap: () {
                                  print("km,m,m,");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllAddsScreen(categoryModel:categoryModel
                                           )),
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            baseUrlImages +
                                                categoryModel.image!,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            Common.LANGCode == "ar"
                                                ? categoryModel.nameArbice!
                                                : (Common.LANGCode == "en"
                                                    ? categoryModel.nameEnglish!
                                                    : categoryModel
                                                        .nameFrance!),
                                            style: const TextStyle(
                                              fontFamily: 'bold',
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                    const SizedBox(
                      height: 40,
                    ),

                    ItemSubCategories(
                        onPress: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,

                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) async {
                              // print(country.name);
                              Common.COUNTRY_USER = country.name;
                              setState(() {});
                              shardPreferencesEditor
                                  .setData(country.name, USER_Country)
                                  .then((value) async {
                                await shardPreferencesEditor
                                    .getData(USER_Country)
                                    .then((value) {
                                  print(value);
                                  Common.COUNTRY_USER = value;
                                });
                              }).onError((error, stackTrace) {
                                print(error);
                              });

                              // await  shardPreferencesEditor.getData(USER_Country);
                            },

                          );
                        },
                        image: "assets/images/country.png",
                        text: Common.COUNTRY_USER.tr() == ""
                            ? "Select Country".tr()
                            : "${Common.COUNTRY_USER.tr()}",
                        color: const Color(0x71000000)),
                    ItemSubCategories(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddAddsScreen(
                                      status:0
                                    )),
                          );
                        },
                        image: "assets/images/img_add_add.png",
                        text: 'Place an Ad'.tr(),
                        color: const Color(0x71000000)),
                    ItemSubCategories(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyAddsScreen(AddCubit.get(context).responseAdd!.currentAdds!,"Active Ads".tr())),
                        );
                      },
                      text: "Active Ads".tr(),
                      image: "assets/images/active.png",
                      color: Colors.black,
                    ),
                    ItemSubCategories(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyAddsScreen(AddCubit.get(context).responseAdd!.unacceptableAdds!,"Rejected Ads".tr())),
                          );
                        },
                        text: "Rejected Ads".tr(),
                        image: "assets/images/rejected.png",
                        color: Colors.black),
                    ItemSubCategories(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyAddsScreen(AddCubit.get(context).responseAdd!.spoonAdds!,"Suspended Ads".tr())),
                          );
                        },
                        text: "Suspended Ads".tr(),
                        image: "assets/images/X.png",
                        color: Colors.black),
                  ],
                )
                    /*Column(
                children: [
                */ /*  Stack(

                    children: [




                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [

                              // ContainerSearch(controller,(){
                              //   pageRout(context, SearchScreen(nameTable: "adds",textSearch:controller.text));
                              // }),
                              const SizedBox(
                                height: 40,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: users.orderBy("time").snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return LinearProgressIndicator();
                                    final docs = snapshot.data!.docs;

                                    return ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: docs.length,
                                        itemBuilder: (_, index) {
                                          return InkWell(
                                            onTap: () {
                                              print("km,m,m,");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AllAddsScreen(
                                                        bar: "Classified ads",
                                                        nameCategory: docs[index]["name"],
                                                        field: "adds")),
                                              );
                                            },
                                            child: Container(
                                              height: 60,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      bottom:
                                                          BorderSide(color: Colors.black))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.network(
                                                        docs[index]["image"],
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        Common.LANGCode=="ar" ? docs[index]["name"]:docs[index]["nameEn"],
                                                        style: const TextStyle(
                                                          fontFamily: 'bold',
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                              const SizedBox(
                                height: 40,
                              ),
                              ItemSubCategories(
                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddAddsScreen(
                                            nameTable: "categoriesAdds",
                                            fieldHome: "adds",
                                          )),
                                    );
                                  },
                                  image: "assets/images/img_add_add.png",
                                  text: 'Place an Ad'.tr(),
                                  color: const Color(0x71000000)),
                              ItemSubCategories(
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyAddsScreen("1", "Active Ads")),
                                  );
                                },
                                text: "Active Ads".tr(),
                                image: "assets/images/active.png",
                                color: Colors.black,
                              ),
                              ItemSubCategories(
                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyAddsScreen("0", "Rejected Ads")),
                                    );
                                  },
                                  text: "Rejected Ads".tr(),
                                  image: "assets/images/rejected.png",
                                  color: Colors.black),
                              ItemSubCategories(
                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyAddsScreen("2", "Suspended Ads")),
                                    );
                                  },
                                  text: "Suspended Ads".tr(),
                                  image: "assets/images/X.png",
                                  color: Colors.black),
                            ],
                          )),

                    ],
                  ),*/ /*
                ],
              ),*/
                    ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: homeColor,
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    width: double.infinity,
                    height: 55,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: Common.LANG,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items:
                            langs.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontFamily: 'bold',
                                fontSize: 15,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        }).toList(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: const SizedBox(),
                        hint: const Text("🇫🇷 FR",
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 15,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            )),
                        onChanged: (String? value) {
                          setState(() {
                            subValue = value;
                            if (value == langs[0]) {
                              context.setLocale(const Locale("ar", "AR"));
                              shardPreferencesEditor.setlang("ar");
                              Common.LANG = "ar";
                              Common.LANGCode = "ar";
                              Navigator.pushNamed(context, "/");
                            } else if (value == langs[1]) {
                              context.setLocale(const Locale("fr", "FR"));
                              shardPreferencesEditor.setlang("fr");
                              Common.LANG = "fr";
                              Common.LANGCode = "fr";
                              Navigator.pushNamed(context, "/");
                            } else {
                              context.setLocale(const Locale("en", "US"));
                              shardPreferencesEditor.setlang("en");
                              Common.LANG = "en";
                              Common.LANGCode = "en";
                              Navigator.pushNamed(context, "/");
                            }
                            getValue();
                          });
                        },
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class ItemSubCategories extends StatelessWidget {
  final String text, image;
  final Color color;
  final void Function() onPress;

  ItemSubCategories(
      {required this.text,
      required this.image,
      required this.color,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(image),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'bold',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerSearch extends StatelessWidget {
  final TextEditingController controller;

  final void Function() onPress, onTap;

  ContainerSearch(this.controller, this.onPress, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,

        onChanged: (value) {
          return null;
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0x99000000),
          height: 2.2,
        ),
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: onPress,
            child: Icon(
              Icons.search,
              size: 25,
              color: Color(0x71000000),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          hintText: "search".tr(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
