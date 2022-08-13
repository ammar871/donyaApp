import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';
import 'package:doniya/app-with-api/models/add_model.dart';
import 'package:doniya/app-with-api/models/profession.dart';
import 'package:doniya/persentaiton/screens/adds/menu_adds_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/commens.dart';
import '../../../../helpers/conatans.dart';
import '../../../../helpers/shard_prefrance.dart';

import '../../../../persentaiton/screens/details_add/detail_add_screen.dart';
import '../../../../persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../profession_screen.dart';

class HomeProfession extends StatefulWidget {
  const HomeProfession({Key? key}) : super(key: key);

  @override
  State<HomeProfession> createState() => _HomeProfessionState();
}

class _HomeProfessionState extends State<HomeProfession> {
  String? subValue;
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfessionCubit.get(context)
        .getProfessionsAdds(id: currentProf.professionId);
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
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(

              onPressed: (){

               Navigator.of(context).pushNamed(profession_splash);

            }, child: Text(
              "تبديل الحساب".tr(),
              style: const TextStyle(
                fontFamily: 'pnuB',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),),
          )
          // SizedBox(
          //   width: 160,
          //   child: DropdownButton<String>(
          //     focusColor: Colors.white,
          //     value: Common.TYPE_ACCOUNT_DROP.tr(),
          //     //value,
          //     isExpanded: false,
          //     style: const TextStyle(color: Colors.white),
          //     iconEnabledColor: Colors.white,
          //     items: typeAccounts
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value.tr(),
          //         child: Text(
          //           value.tr(),
          //           style: const TextStyle(
          //             fontFamily: 'pnuB',
          //             fontSize: 15,
          //             color: Colors.black,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //     icon: Icon(
          //       Icons.keyboard_arrow_down_outlined,
          //       color: Colors.white,
          //     ),
          //     underline: SizedBox(),
          //     hint: Text("نوع الحساب".tr(),
          //         style: TextStyle(
          //           fontFamily: 'pnuB',
          //           fontSize: 15,
          //           color: Colors.white,
          //           fontWeight: FontWeight.w700,
          //         )),
          //     onChanged: (String? value) {
          //       setState(() {
          //         saveData(value!, "type");
          //         Common.TYPE_ACCOUNT_DROP = value;
          //         if (value == typeAccounts[0]) {
          //           Common.TYPE_ACCOUNT_DROP = "صاحب مهنة";
          //           shardPreferencesEditor
          //               .setData("prof", "type")
          //               .then((value) {
          //             Common.TYPE_ACCOUNT = "prof";
          //             Navigator.of(context).pushNamed("/");
          //           });
          //         } else {
          //           Common.TYPE_ACCOUNT_DROP = "طالب خدمة";
          //           shardPreferencesEditor
          //               .setData("user", "type")
          //               .then((value) {
          //             Common.TYPE_ACCOUNT = "user";
          //             Navigator.of(context).pushNamed("/");
          //           });
          //         }
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
      body: BlocConsumer<ProfessionCubit, ProfessionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            child: Stack(
              children: [
                ProfessionCubit.get(context).loadData
                    ? Container(
                        child: Center(
                            child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                              color: homeColor, strokeWidth: 3),
                        )),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            ProfessionCubit.get(context).professions.length,
                        itemBuilder: (_, index) {
                          Profession categoryModel =
                              ProfessionCubit.get(context).professions[index];

                          List<String> stringList =
                              categoryModel.images!.split("#");
                          DateTime now =
                              DateTime.parse(categoryModel.date.toString());
                          String formattedDate =
                              DateFormat('yyyy-MM-dd – kk:mm').format(now);
                          return InkWell(
                            onTap: (){

                              AddModel addModel=AddModel(
                                id: categoryModel.id,
                                categoryId: categoryModel.categoryId,
                                status: categoryModel.status,
                                lang: categoryModel.lang,
                                userId: categoryModel.userId,
                                address: categoryModel.address,
                                lat: categoryModel.lat,
                                phoneWhats: categoryModel.phoneWhats,
                                phone: categoryModel.phone,
                                desc: categoryModel.desc,
                                title: categoryModel.title,
                                advertiserName: categoryModel.advertiserName,
                                country: categoryModel.country,
                                date: categoryModel.date,
                                homeCategory: "",
                                images: categoryModel.images,
                                isImage: categoryModel.isImage,
                                subCategory: "",
                                token: categoryModel.token
                              );


                              pageRout(
                                  context,
                                  DetailsAddScreen(
                                    model: addModel,
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 1))),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          fontFamily: 'pnuM',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: homeColor,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  categoryModel.isImage!
                                      ? Container(
                                          height: 120,
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Image.network(
                                            baseUrlImages + stringList[0],
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SizedBox(),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    categoryModel.title!,
                                    style: const TextStyle(
                                      fontFamily: 'pnuB',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: Text(
                                      "${categoryModel.desc!}",
                                      style: const TextStyle(
                                        fontFamily: 'pnuR',
                                        fontSize: 15,
                                        height: 1.1,
                                        color: Color(0xff000000),
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //whats app
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              openwhatsapp(
                                                  categoryModel.phoneWhats!,
                                                  context);
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black45),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("WhatsApp"),
                                                  Image.asset(
                                                    "assets/images/whatsapp.png",
                                                    width: 20,
                                                    height: 20,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              launch(
                                                  ('tel://${categoryModel.phone!}'));
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black45),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Call Us".tr(),
                                                    style: TextStyle(
                                                        fontFamily: "pnuB"),
                                                  ),
                                                  Icon(
                                                    Icons.call,
                                                    size: 18,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
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
                          items: langs
                              .map<DropdownMenuItem<String>>((String value) {
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
                    )),
                Positioned(

                    bottom: 0,
                    left: 10,


                    child: IconButton(
                      onPressed: () {
                        signOutProfession(ctx: context);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),)
              ],
            ),
          );
        },
      ),
    );
  }
}
