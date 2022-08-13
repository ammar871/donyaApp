import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:doniya/persentaiton/screens/adds/add_adds_screen.dart';
import 'package:doniya/persentaiton/screens/adds/categories_adds.dart';
import 'package:doniya/persentaiton/screens/all_adds/all_adds_screen.dart';
import 'package:doniya/persentaiton/screens/home_screen/componts/custom_drop_dawn_widget.dart';
import 'package:doniya/persentaiton/screens/adds/my_adds_screen.dart';
import 'package:doniya/persentaiton/screens/search_screen/search_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  String? subValue;
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  TextEditingController controller=TextEditingController();
  @override
  build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(aucationHC);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:  Text(
          'Auction ads'.tr(),
          style: const TextStyle(
            fontFamily: 'bold',
            fontSize: 25,
            color: Color(0xff000000),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
        body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [

                Image.asset(
                  "assets/images/back_home.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                         ContainerSearch(controller,(){
                           pageRout(context, SearchScreen(nameTable:"Auction",textSearch:controller.text));
                         }, () {
                           pageRout(context,
                               SearchScreen(nameTable: "adds", textSearch: controller.text));
                         }),
                        ItemSubCategories(
                            onPress: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  AddAddsScreen(nameTable: "ctagoAucation",fieldHome: "Auction",)),
                              // );
                            },
                            image: "assets/images/img_add_add.png",
                            text: 'Place an Ad'.tr(),
                            color: const Color(0x71000000)),
                        const SizedBox(
                          height: 40,
                        ),
                        StreamBuilder<QuerySnapshot>(

                            stream: users.snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const LinearProgressIndicator();
                              final docs = snapshot.data!.docs;

                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: docs.length,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap:  (){
                                        print("km,m,m,");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => AllAddsScreen(
                                        //       bar:"Auction ads", nameCategory: docs[index]["name"],name: docs[index]["name"],field: "Auction")),
                                        // );
                                      },
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
                                                Image.network(docs[index]["image"],height: 50,width: 50,fit: BoxFit.fill,),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  docs[index]["name"],
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
                   /*                 // ItemSubCategories(
                                      onPress: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AllAddsScreen(
                                              bar:"Auction ads", nameCategory: docs[index]["name"],field: "Auction")),
                                        );

                                        // Navigator.of(context).pushNamed(SubCategoriesScreen.id);
                                      },
                                      text: docs[index]["name"],
                                      image: "assets/images/img_add_add.png",
                                      color: const Color(0x71000000),
                                    );*/
                                  });
                            }

                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ItemSubCategories(
                          onPress: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => MyAddsScreen("1","Active Ads")),
                            // );

                          },
                          text: "Active Ads".tr(),
                          image: "assets/images/active.png",
                          color: Colors.black,
                        ),
                        ItemSubCategories(
                            onPress: (){

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => MyAddsScreen("0","Rejected Ads")),
                              // );
                            },
                            text: "Rejected Ads".tr(),
                            image: "assets/images/rejected.png",
                            color: Colors.black),
                        ItemSubCategories(
                            onPress: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => MyAddsScreen("2","Suspended Ads")),
                              // );

                            },
                            text: "Suspended Ads".tr(),
                            image: "assets/images/X.png",
                            color: Colors.black),

                      ],
                    )),


              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black))),
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
                    items:langs.map<DropdownMenuItem<String>>((String value) {
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
                    hint: const Text(
                        "🇫🇷 FR",
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 15,
                          color:  Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        )),
                    onChanged: (String? value) {
                      setState(() {
                        subValue = value;
                        if(value==langs[0]){
                          context.setLocale(const Locale("ar","AR"));
                          shardPreferencesEditor.setlang("ar");
                          Common.LANG = "ar";
                          setState(() {

                          });

                        }else if(value==langs[1]){
                          context.setLocale(const Locale("fr","FR"));
                          shardPreferencesEditor.setlang("fr");
                          Common.LANG = "fr";
                          setState(() {

                          });
                        }
                        else{
                          context.setLocale(const Locale("en","US"));
                          shardPreferencesEditor.setlang("en");
                          Common.LANG = "en";
                          setState(() {

                          });
                        }
                        getValue();
                      });
                    },
                  ),
                ),))
        ],
      ),
    );
  }
}
