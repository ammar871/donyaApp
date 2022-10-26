import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:doniya/app-with-api/bloc/add_cubit/add_cubit.dart';
import 'package:doniya/app-with-api/bloc/category_cubit/category_cubit.dart';
import 'package:doniya/app-with-api/bloc/profession_cubit/profession_cubit.dart';
import 'package:doniya/app-with-api/helpers/functions.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app-with-api/bloc/auth_cubit/auth_cubit.dart';
import 'app_router.dart';

import 'helpers/shard_prefrance.dart';

//custom progress deleting with my adds
// try custom show countries with arabic
//
//

Future<void> _messageHandler(RemoteMessage message) async {
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // NotifyAowsome(notification!.title!,notification.body!);
  // if (notification != null && android != null && !kIsWeb) {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //     id: createUniqueId(),
  //
  //     color: homeColor,
  //     icon: 'resource://drawable/ic_launcher',
  //
  //     channelKey: 'key1',
  //     title:
  //         '${Emojis.money_money_bag + Emojis.plant_cactus}${notification.title}',
  //     body: notification.body,
  //     bigPicture:
  //         "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  //     notificationLayout: NotificationLayout.BigPicture,
  //     // largeIcon: "asset://assets/images/logo_final.png"
  //   ));
  //
  //   print('background message ${message.notification!.body}');
  // }
}

// AndroidNotificationChannel? channel =
//     AndroidNotificationChannel("key1", "chat");
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await getCountry();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;

  await readToken();
 if(Common.TYPE_ACCOUNT!="") await readDataProf();

  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'chat',
      channelDescription: "Notification example",
      defaultColor: Colors.transparent,
      ledColor: Colors.blue,
      channelShowBadge: true,
      importance: NotificationImportance.High,
      // playSound: true,
      // enableLights:true,
      // enableVibration: false
    )
  ]);
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'AR'),
          Locale('fr', 'FR'),
        ],
        path: 'assets/translations',
        saveLocale: true,
        // <-- change the path of the translation files
        fallbackLocale: Locale('ar', 'AR'),
        useFallbackTranslations: false,
        child: MyApp(
          appRouter: AppRouter(),
        )),
  );
}

Future<void> getCountry() async {
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  await shardPreferencesEditor.getData(USER_Country).then((value) {
    if (value != "") {
      Common.COUNTRY_USER = value;
    }
  });


  shardPreferencesEditor.getData("type").then((value) {
    if (value != "") {
      Common.TYPE_ACCOUNT = value;
    }
  });
  shardPreferencesEditor.getData("lang").then((value) {
    if (value != "") {
      Common.LANG = value;
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<CategoryCubit>(
            create: (BuildContext context) => CategoryCubit()),
        BlocProvider<AddCubit>(create: (BuildContext context) => AddCubit()),
        BlocProvider<ProfessionCubit>(create: (BuildContext context) => ProfessionCubit())
        // ChangeNotifierProvider<AddsProviders>(create: (_) => AddsProviders()),
        // ChangeNotifierProvider<AuthProviders>(create: (_) => AuthProviders())
      ],
      child: MaterialApp(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'AR'),
          Locale('fr', 'FR'),
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          ...context.localizationDelegates
        ],

        // supportedLocales: context.supportedLocales,
        locale: context.locale,

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "pnuB",
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(backgroundColor: homeColor)),
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
