import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/ui/privacy_screen/privacy_screen.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/shard_prefrance.dart';
import 'package:doniya/persentaiton/screens/aboute_us/about_us_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app-with-api/helpers/functions.dart';
import '../../../helpers/helper_functions.dart';
import 'componts/custom_drop_dawn_widget.dart';
import 'componts/item_category_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();

  getPermisstion() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.phone,
      Permission.contacts,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    listenMessageNotification();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // print(FirebaseAuth.instance.currentUser!.email! + "sssssssssssss");

      AddCubit.get(context).getAllAdds();
      ProfessionCubit.get(context).getCategoryProfessions();

      // Add Your Code here.
    });
  }


  void listenMessageNotification() async {
    await FirebaseMessaging.instance.subscribeToTopic('user');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        AwesomeNotifications().createNotification(

            content: NotificationContent(
          id: createUniqueId(),

          color: homeColor,
       icon: 'resource://drawable/ic_launcher',

          channelKey: 'key1',
          title:
              notification.title,
          body: notification.body,


              // largeIcon: "asset://assets/images/logo_final.png"
        ));

        // AwesomeNotifications().initialize(
        //     "asset://assets/images/logo_final",
        //     [
        //       NotificationChannel(
        //           channelKey: 'key1',
        //           channelName: 'chat',
        //           channelDescription: "Notification example",
        //           defaultColor: Colors.blue,
        //           ledColor: Colors.blue,
        //           channelShowBadge: true,
        //           playSound: true,
        //           enableLights:true,
        //           enableVibration: false
        //       )
        //     ]
        // );

/*        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            "تم اضافة اعلان في الاعلانات المعلقة",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));*/

        print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    String languageCode = Platform.localeName.split('_').toString();
    print(languageCode);
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            signOut(ctx: context);
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              "assets/images/logo_final.png",
              height: 80,
              width: 80,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'welcome'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                          text: currentUser.fullName!,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          ItemCategoryHome(
              image: "assets/images/advertising.png",
              text: "Classified ads".tr(),
              onPress: () {
                Navigator.of(context).pushNamed(categoAdds);
              }),
          ItemCategoryHome(
              image: "assets/images/auction.png",
              text: "Auction".tr(),
              onPress: () {
                // Navigator.of(context).pushNamed(categAuction);
                showDialog(
                    barrierColor: Colors.black26,
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        title: "",
                        description: "This service will be available soon".tr(),
                      );
                    });
              }),
          ItemCategoryHome(
              image: "assets/images/functionlibiral.png",
              text: "Maintenance".tr(),
              onPress: () {
                if(Common.TYPE_ACCOUNT=="prof"){
                  print(Common.TYPE_ACCOUNT);

                  if(currentProf.id!=null){

                    Navigator.of(context).pushNamed(home_prof);
                  }else {
                    Navigator.of(context).pushNamed(perfession_login);
                  }

                }else if(Common.TYPE_ACCOUNT=="user"){
                  Navigator.of(context).pushNamed(my_adds_prof);
                }else{
                  Navigator.of(context).pushNamed(profession_splash);
                }

                // showDialog(
                //   barrierColor: Colors.black26,
                //   context: context,
                //   builder: (context) {
                //     return CustomAlertDialog(
                //       title: "",
                //       description: "This service will be available soon".tr(),
                //     );
                //   },
                // );
              }),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: 20),
            child: Text(
              'All rights reserved © 2021'.tr(),
              style: TextStyle(
                fontFamily: 'bold',
                fontSize: 15,
                color: Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal:Common.LANGCode == "fr"?2: 10),

                color: homeColor,
                child: CustomDropDawnWidget((value) {
                  print(value);
                  if (value == "0") {
                    context.setLocale(const Locale("ar", "AR"));
                    shardPreferencesEditor.setlang("ar");
                    Common.LANG = "ar";
                    Common.LANGCode = "ar";
                    Navigator.pushNamed(context, "/");
                  } else if (value == "1") {
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
                }),
              ),
              TextButton(
                onPressed: () {


                  pushPage(page: PrivacyPolicyScreen(
                      Common.LANGCode == "ar"
                          ? 0
                          : (Common.LANGCode == "en"
                          ? 1
                          : 2)),context: context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left:Common.LANGCode == "fr"?2: 5,right: Common.LANGCode == "fr"?2: 5),
                  child: Text(
                    'privacybar'.tr(),
                    style: TextStyle(
                      fontFamily: 'pnuB',
                      fontSize:  Common.LANGCode == "fr"?10: 13,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {


                  pushPage(page: AboutUsScreen(
                      Common.LANGCode == "ar"
                      ? 0
                          : (Common.LANGCode == "en"
                      ? 1
                      : 2)),context: context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left:Common.LANGCode == "fr"?2: 5,right:Common.LANGCode == "fr"?2: 5),
                  child: Text(
                    'من نحن'.tr(),
                    style: TextStyle(
                      fontFamily: 'pnuB',
                      fontSize: Common.LANGCode == "fr"?10: 13,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

            ],
          ),
          /* Image.asset(
            "assets/images/back_home.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),*/
          /*  Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * .1,
              child: CustomDropDawnWidget((value) {
                print(value);
                if (value == "0") {
                  context.setLocale(const Locale("ar", "AR"));
                  shardPreferencesEditor.setlang("ar");
                  Common.LANG = "ar";
                  Common.LANGCode="ar";
                  setState(() {});
                } else if (value == "1") {
                  context.setLocale(const Locale("fr", "FR"));
                  shardPreferencesEditor.setlang("fr");
                  Common.LANG = "fr";
                  Common.LANGCode="fr";
                  setState(() {});
                } else {
                  context.setLocale(const Locale("en", "US"));
                  shardPreferencesEditor.setlang("en");
                  Common.LANG = "en";
                  Common.LANGCode="en";
                  setState(() {});
                }
              })),
          Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  ItemCategoryHome(
                      image: "assets/images/fixing.png",
                      text: "Maintenance".tr(),
                      onPress: () {
                        // Navigator.of(context).pushNamed(categMaintence);
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              title: "",
                              description:
                                  "'This service will be available soon'",
                            );
                          },
                        );
                      }),
                  const SizedBox(
                    height: 55,
                  ),
                  ItemCategoryHome(
                      image: "assets/images/megaphone.png",
                      text: "Classified ads".tr(),
                      onPress: () {
                        Navigator.of(context).pushNamed(categoAdds);
                      }),
                  const SizedBox(
                    height: 55,
                  ),
                  ItemCategoryHome(
                      image: "assets/images/mazad.png",
                      text: "Auction".tr(),
                      onPress: () {
                        // Navigator.of(context).pushNamed(categAuction);
                        showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                title: "",
                                description:
                                    "This service will be available soon".tr(),
                              );
                            });
                      })
                ],
              )),
           Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'All rights reserved © 2021'.tr(),
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 15,
                  color: Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          )*/
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
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
          // Text(
          //   "${widget.title}",
          //   style: TextStyle(
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: 15),
          Text(
            "${widget.description}",
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
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  "Ok".tr(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
