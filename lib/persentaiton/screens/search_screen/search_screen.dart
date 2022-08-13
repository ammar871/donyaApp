import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/models/add_model.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';

import 'package:doniya/persentaiton/screens/adds/repository_adds/adds_providers.dart';
import 'package:doniya/persentaiton/screens/details_add/detail_add_screen.dart';
import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import 'package:doniya/persentaiton/screens/adds/menu_adds_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String nameTable, textSearch;

  SearchScreen({required this.nameTable, required this.textSearch});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  String? subValue;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.textSearch);
    if (Common.COUNTRY_USER == "")
      AddCubit.get(context).searchAdds(coutry: Common.COUNTRY_USER,nameAdd: widget.textSearch.trim());
    else
      AddCubit.get(context)
          .searchAdds(coutry: Common.COUNTRY_USER, nameAdd: widget.textSearch.trim());
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection("adds");
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          "the search".tr(),
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
            children: [
              // CustomDropDownWidget(
              //     list: ["adds","Auction","Maintenance"],
              //     onSelect: (onSelect) {
              //       selcteTupe = onSelect;
              //
              //     },
              //     hint: "Select Category"),

              Positioned(
                  top: 0.0,
                  left: 0,
                  right: 0,
                  bottom: 50.0,
                  child: AddCubit.get(context).loadSearchAdds
                      ? Container(
                          child: Center(
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 5,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              AddCubit.get(context).searchAddsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            AddModel model =
                                AddCubit.get(context).searchAddsList[index];
                            return InkWell(
                                onTap: () {
                                  print("dddd");
                                  pageRout(
                                      context,
                                      DetailsAddScreen(
                                        model: model,
                                      ));
                                },
                                child: ItemProductSearch(model: model));
                          },
                        )),

              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
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
                              setState(() {});
                            } else if (value == langs[1]) {
                              context.setLocale(const Locale("fr", "FR"));
                              shardPreferencesEditor.setlang("fr");
                              Common.LANG = "fr";
                              Common.LANGCode = "fr";
                              setState(() {});
                            } else {
                              context.setLocale(const Locale("en", "US"));
                              shardPreferencesEditor.setlang("en");
                              Common.LANG = "en";
                              Common.LANGCode = "en";
                              setState(() {});
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
