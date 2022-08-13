// import 'package:another_flushbar/flushbar.dart';
import 'package:doniya/app-with-api/ui/auth_with_api_screens/login_api_screen.dart';
import 'package:doniya/app-with-api/ui/profession_screen/profession_auth/profession_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/commens.dart';
import '../../helpers/shard_prefrance.dart';
import '../../persentaiton/screens/login_screeen/login_screen.dart';
import 'constants.dart';

signOut({ctx}) async {
  ShardPreferencesEditor shardPreferencesEditor = ShardPreferencesEditor();
  final storage = new FlutterSecureStorage();

  token = "";
  await storage.delete(key: "token");
  shardPreferencesEditor.loigOut();
  Common.COUNTRY_USER = "";

  // await storage.delete(key: "id");
  replacePage(context: ctx, page: LoginApiScreen());
}



signOutProfession({ctx}) async {

  final ShardPreferencesEditor editor =  ShardPreferencesEditor();



  editor.removeKey(key: "type").then((value) {
    Common.TYPE_ACCOUNT="";
    currentProf.id=null;
    // await storage.delete(key: "id");
    replacePage(context: ctx, page: ProfessionAuth());

  });


}

pop(context) {
  Navigator.of(context).pop();
}

pushPage({context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

// getDataUser(){
//   ShardEditor editor=ShardEditor();
//   editor.getUser().then((value) {
//
//     currentUser = value;
//     token=value.token!;
//     printFunction("cerrentUser${currentUser.token}");
//   });
// }

bool isLogin() {
  return token != "";
}

readToken() async {
  // await getBaseUrl();
  const storage = FlutterSecureStorage();
  try {
    token = (await storage.read(key: "token"))!;
    currentUser.id = (await storage.read(key: "id"));
    currentUser.role = (await storage.read(key: "role"));
    currentUser.fullName = (await storage.read(key: "name"));
    currentUser.imageUrl = (await storage.read(key: "image"));
    printFunction("token : ${currentUser.id!}");
  } catch (e) {}
}

setValue(){

}

isRegistered() {
  return (token != "" && token != null);
}

saveToken() {
  const storage = FlutterSecureStorage();
  storage.write(key: 'token', value: token);
  storage.write(key: 'id', value: currentUser.id);
  storage.write(key: 'role', value: currentUser.role);
  storage.write(key: 'image', value: currentUser.imageUrl);
  storage.write(key: 'name', value: currentUser.fullName);
}

saveData(String value, String KeyStorage) {
  const storage = FlutterSecureStorage();
  storage.write(key: KeyStorage, value: value);
}

Future<String?> readData(String key) async {
  const storage = FlutterSecureStorage();

  return storage.read(key: key);
}

saveDataProf() {
  const storage = FlutterSecureStorage();
  storage.write(key: 'emailProf', value: currentProf.email);
  storage.write(key: 'nameProf', value: currentProf.fullName);
  storage.write(key: 'idProf', value: currentProf.id.toString());
  storage.write(key: 'profId', value: currentProf.professionId);
}

readDataProf() async {
  const storage = FlutterSecureStorage();

  currentProf.email = (await storage.read(key: "emailProf"));
  currentProf.fullName = (await storage.read(key: "nameProf"));
  currentProf.id = (await storage.read(key: "idProf"));
  currentProf.professionId = (await storage.read(key: "profId"));
  Common.TYPE_ACCOUNT_DROP = (await storage.read(key: "type"))??"";
}

class HelperFunction {
  static HelperFunction slt = HelperFunction();

  notifyUser({context, message, color, bool isNeedPop = false}) {
    // return Flushbar(
    //   padding: const EdgeInsets.all(30),
    //   flushbarStyle: FlushbarStyle.GROUNDED,
    //   flushbarPosition: FlushbarPosition.TOP,
    //   message: message,
    //   duration: const Duration(seconds: 3),
    //   backgroundColor: color,
    //   animationDuration: const Duration(milliseconds: 400),
    //   leftBarIndicatorColor: color,
    // )..show(context).whenComplete(() {
    //     if (isNeedPop) pop(context);
    //   });
    final snackBar = SnackBar(

      backgroundColor: color,
      content:  Text(message,style: TextStyle(
          fontFamily: "pnuB"

      ),),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSheet(BuildContext context, child) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return child;
      },
    );
  }

// openGoogleMapLocation(lat, lng) async {
//   String mapOptions = [
//     'saddr=${locData.latitude},${locData.longitude}',
//     'daddr=$lat,$lng',
//     'dir_action=navigate'
//   ].join('&');
//
//   final url = 'https://www.google.com/maps?$mapOptions';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

}
