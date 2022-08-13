import 'package:shared_preferences/shared_preferences.dart';


const String USER_Country = "uesr_country";
class ShardPreferencesEditor {
  final String USER_TOKEN = "auth_token";
  final String USER_LANG_KEY = "lang";
  final String USER_ID = "uesr_id";
  final String USER_IS_LOGIN = "uesr_login";


  final String USER_SELECT_SERVICE = "uesr_service";

/*//set data into shared preferences like this
  Future<void> setAuthToken(String authToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(this.USER_TOKEN, authToken);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  String authToken;
  authToken = pref.getString(this.USER_TOKEN) ?? null;
  return authToken;
  }*/

  //set data into shared preferences like this
  Future<void> setlang(String saveLang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_LANG_KEY, saveLang);
  }

//get value from shared preferences
  Future<String> getlang() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String langsaveed;
    langsaveed = pref.getString(USER_LANG_KEY) ?? "";
    return langsaveed;
  }
  Future<String?> setData(String saveLang,String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, saveLang);
  }

//get value from shared preferences
  Future<String> getData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String langsaveed;
    langsaveed = pref.getString(key) ?? "";
    return langsaveed;
  }

  void loigOut()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

/*
  //set data into shared preferences like this
  Future<void> setUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.USER_ID, userId);
  }

//get value from shared preferences
  Future<String> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userId;
    userId = pref.getString(this.USER_ID) ?? null;
    return userId;
  }



   //set data into shared preferences like this
  Future<bool> setIsLogin(bool islogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.USER_IS_LOGIN, islogin);
  }

//get value from shared preferences
  Future<bool> getIsLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool logined = false;
    logined = pref.getBool(this.USER_IS_LOGIN) ?? null;
    return logined;
  }

  //set data into shared preferences like this
  Future<int> setSelectService(int islogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(this.USER_SELECT_SERVICE, islogin);
  }

//get value from shared preferences
  Future<int> getSelectService() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int logined = 0;
    logined = pref.getInt(this.USER_SELECT_SERVICE) ?? null;
    return logined;
  }

  void loigOut()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }*/

  Future removeKey({key})async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
