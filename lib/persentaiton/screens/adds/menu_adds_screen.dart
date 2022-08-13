import 'dart:io';

import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';

import 'package:doniya/persentaiton/screens/adds/categories_adds.dart';

import 'package:doniya/persentaiton/screens/details_add/detail_add_screen.dart';

import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import 'package:doniya/persentaiton/screens/search_screen/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app-with-api/models/add_model.dart';

class MenuAddsScreen extends StatefulWidget {
  final SubCategoryResponse subCategoryResponse;

  MenuAddsScreen(this.subCategoryResponse);

  @override
  State<MenuAddsScreen> createState() => _MenuAddsScreenState();
}

class _MenuAddsScreenState extends State<MenuAddsScreen> {
  String? subValue;
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  TextEditingController controllerSearch = TextEditingController();

  final ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddCubit.get(context).getAddsPagination(
        catId: widget.subCategoryResponse.subCategory!.id!,
        country: Common.COUNTRY_USER,page: 1);

    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        if (page >= AddCubit.get(context).addsPagination!.totalPage!) {
          return;
        } else {
          page++;

print("pageNumber"+page.toString());
          AddCubit.get(context).pagination(
              catId: widget.subCategoryResponse.subCategory!.id!,
              page: page,
              country: Common.COUNTRY_USER);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerSearch.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          AddCubit.get(context).getAddsPagination(
              catId: widget.subCategoryResponse.subCategory!.id!,
              country: Common.COUNTRY_USER,page: 1);
          page=1;
        },
      ),
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          Common.LANGCode == "ar"
              ? widget.subCategoryResponse.subCategory!.nameArbice!
              : (Common.LANGCode == "en"
                  ? "${widget.subCategoryResponse.subCategory!.nameEnglish}"
                  : "${widget.subCategoryResponse.subCategory!.nameFrance}"),
          style: const TextStyle(
            fontFamily: 'bold',
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<AddCubit, AddState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: ContainerSearch(controllerSearch, () {
                    pageRout(
                        context,
                        SearchScreen(
                          nameTable: "widget.nameTable",
                          textSearch: controllerSearch.text,
                        ));
                  }, () {
                    // pageRout(context,
                    //     SearchScreen(nameTable: "adds", textSearch: controller.text));
                  })),



              Positioned(
                top: 60.0,
                left: 0,
                right: 0,
                bottom: 50.0,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: AddCubit.get(context).loadAdds
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
                      : ListView.builder(

                          controller: _controller,
                          // physics: BouncingScrollPhysics(),
                          itemCount: AddCubit.get(context).newList.length,

                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  print("dddd");
                                  pageRout(
                                      context,
                                      DetailsAddScreen(
                                        model:
                                        AddCubit.get(context).newList[index],
                                      ));
                                },
                                child: ItemProductSearch(
                                    model: AddCubit.get(context).newList[index]));
                          },
                        ),
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
                              Navigator.pushNamed(context, "/");
                            } else if (value == langs[1]) {
                              context.setLocale(const Locale("fr", "FR"));
                              shardPreferencesEditor.setlang("fr");
                              Common.LANG = "fr";
                              Navigator.pushNamed(context, "/");
                            } else {
                              context.setLocale(const Locale("en", "US"));
                              shardPreferencesEditor.setlang("en");
                              Common.LANG = "en";
                              Navigator.pushNamed(context, "/");
                            }
                            getValue();
                          });
                        },
                      ),
                    ),
                  )),
              AddCubit.get(context).loadingPage?

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20),
                    color: Colors.black.withOpacity(.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ):SizedBox()


            ],
          );
        },
      ),
    );
  }
}

class ItemProduct extends StatefulWidget {
  final AddModel model;

  ItemProduct({required this.model});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  var output;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timestamp t = widget.model.time!;
    // DateTime d = t.toDate();
    // print(d.toString());
    //
    // output = DateFormat('dd/MM/yyyy, h:mma').format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          widget.model.isImage!
              ? Container(
                  height: 120,
                  // padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    widget.model.images![0],
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model.title!,
                      style: const TextStyle(
                        fontFamily: 'light',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      output,
                      style: const TextStyle(
                        fontFamily: 'light',
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color(0xad797777),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: 120,
                  child: Text(
                    widget.model.desc!,
                    style: const TextStyle(
                      fontFamily: 'light',
                      fontSize: 11,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color(0xffE4AB10),
                border: Border(top: BorderSide(color: Colors.black, width: 1))),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      widget.model.address!,
                      style: const TextStyle(
                        fontFamily: 'light',
                        fontSize: 11,
                        color: Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemProductSearch extends StatefulWidget {
  final AddModel model;

  ItemProductSearch({required this.model});

  @override
  State<ItemProductSearch> createState() => _ItemProductSearchState();
}

class _ItemProductSearchState extends State<ItemProductSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> stringList = widget.model.images!.split("#");
    DateTime now = DateTime.parse(widget.model.date.toString());
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm',Common.LANGCode).format(now);
    return Container(
      height: 190,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: homeColor, width: 2))),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xad797777),
                ),
                textAlign: TextAlign.start,
              ),
              widget.model.isImage!
                  ? Container(
                      height: 120,
                      // padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.network(
                        baseUrlImages + stringList[0],
                        height: 110,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      width: 100,
                    ),
            ],
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.model.title!,
                  style: const TextStyle(
                    fontFamily: 'light',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                ),
                Container(

                  child: Text(
                    "${widget.model.desc!}",
                    style: const TextStyle(
                      fontFamily: 'light',
                      fontSize: 15,
                      height: 1.1,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    //whats app
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          openwhatsapp(widget.model.phoneWhats!, context);
                        },
                        child: Center(
                          child: Container(

                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/whatsapp.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                                Text("Whats"),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          launch(('tel://${widget.model.phone!}'));
                        },
                        child: Container(
                          width: 115,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 18,
                                color: Colors.blue,
                              ),
                              Text("Call Us".tr()),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

openwhatsapp(phoneNumber, BuildContext context) async {
  var whatsapp = "$phoneNumber";
  var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=hello";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}
