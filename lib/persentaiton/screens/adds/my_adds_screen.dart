import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';

import 'package:doniya/persentaiton/screens/adds/categories_adds.dart';
import 'package:doniya/persentaiton/screens/adds/update_add_screen.dart';

import 'package:doniya/persentaiton/screens/details_add/detail_add_screen.dart';
import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import 'package:doniya/persentaiton/screens/search_screen/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app-with-api/helpers/functions.dart';
import '../../../app-with-api/models/add_model.dart';

class MyAddsScreen extends StatefulWidget {
  final List<AddModel> list;
  final String bar;

  MyAddsScreen(this.list, this.bar);

  @override
  State<MyAddsScreen> createState() => _MyAddsScreenState();
}

class _MyAddsScreenState extends State<MyAddsScreen> {
  TextEditingController controller = TextEditingController();
  String? subValue;
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance
    //     .collection("DataUsers")
    //     .doc(Common.userId)
    //     .collection("adds");
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          widget.bar,
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
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.list.length,
                      itemBuilder: (_, index) {
                        AddModel addModel = widget.list[index];
                        List<String> stringList = addModel.images!.split("#");
                        DateTime now = DateTime.parse(addModel.date.toString());
                        String formattedDate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(now);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsAddScreen(model: addModel)),
                            );
                          },
                          child: Container(

                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                addModel.isImage!
                                    ? Image.network(
                                  baseUrlImages + stringList[0],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ):SizedBox(),

                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  addModel.title!,
                                  style: const TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierColor: Colors.black26,
                                          context: context,
                                          builder: (context) {
                                            return CustomAlertDialogDeleting(
                                                addModel, widget.list);
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        pushPage(context: context,page: UpdateAddScreen(addModel));
                                      },
                                      icon: const Icon(
                                        Icons.update,
                                        size: 20,
                                        color: Colors.green,
                                      ),
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
                        items: <String>[
                          'العربية 🇹🇳',
                          '🇫🇷  Fr',
                          '🇬🇧 Eng',
                        ].map<DropdownMenuItem<String>>((String value) {
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

class CustomAlertDialogDeleting extends StatefulWidget {
  final AddModel model;
  final List<AddModel> list;

  CustomAlertDialogDeleting(this.model, this.list);

  @override
  _CustomAlertDialogDeletingState createState() =>
      _CustomAlertDialogDeletingState();
}

class _CustomAlertDialogDeletingState extends State<CustomAlertDialogDeleting> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Dialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25),
              Text(
                "Are you sure you want to delete".tr(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "${widget.model.title}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                 AddCubit.get(context).loadDeleteAdd?Center(
                   child: CircularProgressIndicator(
                     color: Colors.black,
                   ),
                 ) :  InkWell(
                      highlightColor: Colors.grey[200],
                      onTap: () {

                        widget.list.remove(widget.model);
                        AddCubit.get(context).deleteAdd(
                            context: context,
                            onSuccess: () {
                              AddCubit.get(context).getAllAdds();

                            },
                            id: widget.model.id);

                        // context.read<AddsProviders>().deletingMyAdds(
                        //   tableName: "adds",
                        //     userId: "${widget.model.userid}",
                        //     name: widget.model.name,
                        //     context: context);
                        // setState(() {
                        //  Navigator.pop(context);
                        // });
                      },
                      child: Center(
                        child: Text(
                          "Deleting".tr(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.grey[200],
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Cancel".tr(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
