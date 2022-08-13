import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';

import 'package:doniya/app-with-api/models/category_profession.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/commens.dart';
import '../../../../helpers/conatans.dart';
import '../../../../helpers/shard_prefrance.dart';
import '../../../helpers/constants.dart';
import '../../../models/profession.dart';
import '../add_profession_screen/add_profession_screen.dart';

class MyAddsProfScreen extends StatefulWidget {
  const MyAddsProfScreen({Key? key}) : super(key: key);

  @override
  State<MyAddsProfScreen> createState() => _MyAddsProfScreenState();
}

class _MyAddsProfScreenState extends State<MyAddsProfScreen> {

  ShardPreferencesEditor editor = ShardPreferencesEditor();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfessionCubit.get(context).getMyProfessionsAdds();
    ProfessionCubit.get(context).getCategoryProfessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.small(
      //   backgroundColor: homeColor,
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   elevation: 12,
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (_) =>
      //               AddProfessionScreen(status: 0, prof: Profession()),
      //         ));
      //   },
      // ),
      appBar: AppBar(
          backgroundColor: homeColor,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),

          title: Text(
            "Maintenance".tr(),
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: "pnuB"),
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
      ],),
      body: BlocConsumer<ProfessionCubit, ProfessionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ProfessionCubit.get(context).loadData
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
                  itemCount: ProfessionCubit.get(context).categoryProfessions.length,
                  itemBuilder: (_, index) {
                    CategoryProfession categoryModel =
                    ProfessionCubit.get(context).categoryProfessions[index];



                    return GestureDetector(
                      onTap: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddProfessionScreen(status: 0, prof: categoryModel),
                            ));
                      },
                      child: Container(

                        height: 100,
                        decoration: BoxDecoration(
                          border:Border(
                            bottom: BorderSide(
                              color: Colors.grey,width: 1
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            Common.LANGCode == "ar"
                                ? categoryModel.nameArbice!
                                : (Common.LANGCode == "en"
                                ? categoryModel.nameEnglish!
                                : categoryModel
                                .nameFrance!),
                            style: const TextStyle(
                              fontFamily: 'pnuM',
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              color: homeColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}

class ItemAddsProfessions extends StatelessWidget {
  const ItemAddsProfessions({
    Key? key,
    required this.formattedDate,
    required this.categoryModel,
    required this.stringList,
  }) : super(key: key);

  final String formattedDate;
  final Profession categoryModel;
  final List<String> stringList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black26, width: 1))),
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
                      borderRadius: BorderRadius.circular(8)),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //whats app
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print("ddddddd");

                      showDialog(
                        barrierColor: Colors.black26,
                        context: context,
                        builder: (context) {
                          return CustomAlertDialogDeletingProf(
                              categoryModel,
                              ProfessionCubit.get(context)
                                  .professions);
                        },
                      );
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black45),
                      ),
                      padding: EdgeInsets.all(5),
                      child:  Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  "حذف".tr(),
                                  style: TextStyle(
                                      fontFamily: "pnuB",
                                      color: Colors.red),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) =>
                      //           AddProfessionScreen(status: 1, prof:categoryModel),
                      //     ));
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.black45),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Text(
                            "Update".tr(),
                            style:
                                TextStyle(fontFamily: "pnuB"),
                          ),
                          Icon(
                            Icons.update,
                            size: 18,
                            color: Colors.green,
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
    );
  }
}

class CustomAlertDialogDeletingProf extends StatefulWidget {
  final Profession model;
  final List<Profession> list;

  CustomAlertDialogDeletingProf(this.model, this.list);

  @override
  _CustomAlertDialogDeletingState createState() =>
      _CustomAlertDialogDeletingState();
}

class _CustomAlertDialogDeletingState
    extends State<CustomAlertDialogDeletingProf> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessionCubit, ProfessionState>(
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
                    ProfessionCubit.get(context).loadDeleteAdd
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : InkWell(
                            highlightColor: Colors.grey[200],
                            onTap: () {
                              widget.list.remove(widget.model);
                              ProfessionCubit.get(context).deleteAdd(
                                  context: context,
                                  onSuccess: () {
                                    ProfessionCubit.get(context)
                                        .getMyProfessionsAdds();
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
