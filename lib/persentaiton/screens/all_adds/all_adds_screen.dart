import 'package:doniya/app-with-api/bloc/category_cubit/category_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';

import 'package:doniya/persentaiton/screens/adds/categories_adds.dart';
import 'package:doniya/persentaiton/screens/adds/menu_adds_screen.dart';
import 'package:doniya/persentaiton/screens/adds/repository_adds/adds_providers.dart';

import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';

import 'package:doniya/persentaiton/screens/search_screen/search_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class AllAddsScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  AllAddsScreen({required this.categoryModel});

  @override
  State<AllAddsScreen> createState() => _AllAddsScreenState();
}

class _AllAddsScreenState extends State<AllAddsScreen> {
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  String? subValue;

  //
  // getNameTable() {
  //   if (widget.field == "adds") {
  //     return classifiedAdsSC;
  //   } else if (widget.field == "Auction") {
  //     return aucationSC;
  //   } else {
  //     return maintenanceSC;
  //   }
  // }

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // print("alllllllllll${widget.name}");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // getCounters(widget.name).then((value) {
      //
      //   setState(() {
      //
      //   });
      // });

      CategoryCubit.get(context)
          .getSubCategoryByCatId(catId: widget.categoryModel.id,cuntry: Common.COUNTRY_USER);
    });

    // Add Your Code here.
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
          CategoryCubit.get(context)
              .getSubCategoryByCatId(catId: widget.categoryModel.id,cuntry: Common.COUNTRY_USER);
        },
      ),
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          Common.LANGCode == "ar"
              ? widget.categoryModel.nameArbice!
              : (Common.LANGCode == "en"
                  ? "${widget.categoryModel.nameEnglish}"
                  : "${widget.categoryModel.nameFrance}"),
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
              Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
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
                  })),
              Positioned(
                  top: 60.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 50.0,
                  child: CategoryCubit.get(context).loadSubCategories
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              CategoryCubit.get(context).SubCategories.length,
                          itemBuilder: (_, index) {
                            SubCategoryResponse subCategoryResponse =
                                CategoryCubit.get(context).SubCategories[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuAddsScreen(
                                            subCategoryResponse)));
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
                                              subCategoryResponse
                                                  .subCategory!.image!,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          Common.LANGCode == "ar"
                                              ? subCategoryResponse
                                                  .subCategory!.nameArbice!
                                              : (Common.LANGCode == "en"
                                                  ? "${subCategoryResponse.subCategory!.nameEnglish!}"
                                                  : "${subCategoryResponse.subCategory!.nameFrance!}"),
                                          style: const TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${subCategoryResponse.conter}",
                                          style: const TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                        ),
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
                          })),
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

  // String getCounter(nameTable, nameItem) {
  //   if (nameTable == "عقارات") {
  //     return "${context.watch<AddsProviders>().counters.firstWhere((element) => element.name == nameItem).count}";
  //   } else if (nameTable == "خدمات") {
  //     return "${context.watch<AddsProviders>().countersServes.firstWhere((element) => element.name == nameItem).count}";
  //   } else if (nameTable == "السيارات") {
  //     return "${context.watch<AddsProviders>().countersCars.firstWhere((element) => element.name == nameItem).count}";
  //   } else if (nameTable == "منوعات") {
  //     return "${context.watch<AddsProviders>().countersOthers.firstWhere((element) => element.name == nameItem).count}";
  //   } else {
  //     return "${context.watch<AddsProviders>().countersJobs.firstWhere((element) => element.name == nameItem).count}";
  //   }
  // }

  Future getCounters(nameTable) async {
    if (nameTable == "عقارات") {
      context
          .read<AddsProviders>()
          .getCounterAdds(context.read<AddsProviders>().subCategories);
    } else if (nameTable == "خدمات") {
      context
          .read<AddsProviders>()
          .getCounterAdds(context.read<AddsProviders>().subCategoriesServes);
    } else if (nameTable == "السيارات") {
      context
          .read<AddsProviders>()
          .getCounterAdds(context.read<AddsProviders>().subCategoriesCars);
    } else if (nameTable == "منوعات") {
      context
          .read<AddsProviders>()
          .getCounterAdds(context.read<AddsProviders>().subCategoriesOthers);
    } else {
      context
          .read<AddsProviders>()
          .getCounterAdds(context.read<AddsProviders>().subCategoriesJobs);

      //  "${context.watch<AddsProviders>().countersJobs.firstWhere((element) => element.name == nameItem).count}";
    }
  }
}
