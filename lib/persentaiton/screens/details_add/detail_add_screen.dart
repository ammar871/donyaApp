import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/persentaiton/screens/details_add/show_images_screen.dart';
import 'package:doniya/persentaiton/screens/maps/show_location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doniya/models/adds_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app-with-api/models/add_model.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class DetailsAddScreen extends StatefulWidget {
  final AddModel model;

  DetailsAddScreen({required this.model});

  @override
  State<DetailsAddScreen> createState() => _DetailsAddScreenState();
}

class _DetailsAddScreenState extends State<DetailsAddScreen> {
  final TextEditingController _controller = TextEditingController();

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

    // print(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    List<String> stringList = widget.model.images!.split("#");
    DateTime now = DateTime.parse(widget.model.date.toString());
    String formattedDate =
    DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: true,
        title: Text(
          widget.model.title!,
          style:
              TextStyle(fontFamily: "black", fontSize: 25, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          widget.model.isImage!
              ? InkWell(
                  onTap: () {
                    pageRout(context,
                        ShowingImagesScreen(images: stringList));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    child: Image.network(
                     baseUrlImages+ stringList[0],
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : SizedBox(),
          const SizedBox(
            height: 20,
          ),
          Text(
           widget.model.desc!,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "bold", fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              launch(('tel://${widget.model.phone!}'));
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xff1F05D2),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Center(
                      child: Text(
                        widget.model.phone!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "bold"),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.model.phoneWhats != null
              ? InkWell(
                  onTap: () {
                    // pageRout(context, ShowLocation(widget.model.location!.split("/")[1],widget.model.location!.split("/")[0]));
                    // setState(() {});
                  },
                  child: InkWell(
                    onTap: (){
                      openwhatsapp(widget.model.phoneWhats!);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xff03b133),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset("assets/images/whatsapp.png",width: 20,height: 20,fit: BoxFit.fill,),
                            Expanded(
                                child: Center(
                              child: Text(
                                widget.model.phoneWhats!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "bold"),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              try {
                PermissionStatus permission = await Permission.contacts.status;
                if (permission != PermissionStatus.granted) {
                  await Permission.contacts.request();
                  PermissionStatus permission =
                      await Permission.contacts.status;

                  if (permission == PermissionStatus.granted) {
                    // set up the button
                    Widget okButton = TextButton(
                      child:  Text("حفظ".tr()),
                      onPressed: () async {
                        Contact newContact = Contact();
                        newContact.givenName = _controller.text;

                        newContact.phones = [
                          Item(label: "mobile", value: widget.model.phone)
                        ];

                        await ContactsService.addContact(newContact)
                            .then((value) {
                          Navigator.of(context).pop();
                          final snackBar = SnackBar(
                            content:  Text('تمت الاضافةالى جهة الاتصال'.tr()),
                            action: SnackBarAction(
                              label: "",
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title:  Text("أدخل اسم جهة الاتصال".tr()),
                      content: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: TextField(
                          textAlign: TextAlign.right,
                          controller: _controller,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            height: 2.2,
                          ),
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            hintText: "ادخل الاسم".tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      actions: [
                        okButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                } else {
                  Widget okButton = TextButton(
                    child:  Text("حفظ".tr()),
                    onPressed: () async {
                      Contact newContact = Contact();
                      newContact.givenName = _controller.text;

                      newContact.phones = [
                        Item(label: "mobile", value: widget.model.phone)
                      ];

                      await ContactsService.addContact(newContact)
                          .then((value) {
                        final snackBar = SnackBar(
                          content:  Text('تمت الاضافةالى جهة الاتصال'.tr()),
                          action: SnackBarAction(
                            label: "",
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      });
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title:  Text("أدخل اسم جهة الاتصال".tr()),
                    content: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          height: 2.2,
                        ),
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          hintText: "ادخل الاسم".tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    actions: [
                      okButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              } catch (e) {
                print(e);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xff02A58F),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.person_add_alt_1,
                      size: 20,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Center(
                      child: Text(
                        "اضافة الى جهات الاتصال".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "bold"),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              openGoogleMapLocation(widget.model.lat, widget.model.lang);
              setState(() {

              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xffAC0896),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const   SizedBox(
                      width: 20,
                    ),
                    const   Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Center(
                      child: Text(
                        "الموقــع على الخريطـة".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "bold"),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );



  }
  openwhatsapp(phoneNumber) async{
    var whatsapp ="$phoneNumber";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }


openGoogleMapLocation(lat, lng) async {
  String mapOptions = [
    'saddr=${locData.latitude},${locData.longitude}',
    'daddr=$lat,$lng',
    'dir_action=navigate'
  ].join('&');

  final url = 'https://www.google.com/maps?$mapOptions';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
