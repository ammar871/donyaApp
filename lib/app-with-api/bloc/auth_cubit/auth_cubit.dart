import 'dart:convert';



import 'package:doniya/helpers/conatans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/user_model.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String countryCode="971+";

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  checkUserName({phone}) async {
    emit(CheckUserAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + checkUserNamePoint));
    request.fields.addAll({'phone': phone});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      print(jsonData);

      emit(CheckUserAuthStateSuccess(
          phone: phone, code: jsonData["code"], status: jsonData["status"]));
    } else {
      print("errrrrrrrrrror"+response.statusCode.toString());
      emit(CheckUserAuthStateError());
    }
  }

  bool isValidate = false;

  validateUser({username, email, fullName}) async {
    emit(ValidateAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + validatePoint));
    request.fields.addAll({'email': email, 'userName': username});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);

      registerUser(email: email, userName: username, fullName: fullName,endPoint: registerPoint,status: 0);
    } else if (response.statusCode == 400) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);
      emit(ValidateAuthStateError(jsonsDataString));
    } else {
      printFunction(response.statusCode);
      emit(ValidateAuthStateError("errrrrrrrrrror"));
    }
  }

  registerUser({fullName, email, userName,endPoint,status,onSuccess}) async {

    if(status==0)
    emit(RegisterAuthStateLoad());


    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + endPoint));
    request.fields.addAll({
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'knownName': 'askdkalshkjsa',
      'Role': 'user',
      'password': 'Abc123@'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      if(status==0)
      emit(RegisterAuthStateSuccess(code: jsonData["code"], userName: userName));
      else{


        UserResponse userResponse = UserResponse.fromJson(jsonData);
        token = "Bearer " + userResponse.token!;
        currentUser = user = userResponse.user!;

        // if(data['driver']!=null) currentUser.driver = Driver.fromJson(data['driver']);
        await saveToken();
        printFunction("currentUser${token}");

        printFunction(userResponse.token);
        onSuccess();
        if(status==1)
        loadLoginGoogle=false;
        else
          loadFaceLogin=false;
      }

    } else {
      printFunction(response.reasonPhrase);
      emit(RegisterAuthStateError());
    }
  }

  UserModel user = UserModel();

  loginUser({code, userName}) async {
    emit(LoginAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + loginPoint));
    request.fields.addAll({'code': code, 'userName': userName});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      UserResponse userResponse = UserResponse.fromJson(jsonData);
      token = "Bearer " + userResponse.token!;
      currentUser = user = userResponse.user!;

      // if(data['driver']!=null) currentUser.driver = Driver.fromJson(data['driver']);
      await saveToken();
      printFunction("currentUser${token}");

      printFunction(userResponse.token);

      emit(LoginAuthStateSuccess(userResponse));
    } else {
      printFunction("errrrrrrrrrror");
      emit(LoginAuthStateError());
    }
  }

  bool isChecked = false;

  changeCheckBox(bool checked) {
    isChecked = checked;
    printFunction(isChecked);
    emit(ChangeCheckBox());
  }


bool loadLoginGoogle=false;
  Future loginWithGoogle({context}) async {
    loadLoginGoogle=true;
  emit(LoginSocialAuthStateLoad());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value){

        registerUser(endPoint: loginSocialPoint,fullName: value.user!.displayName,userName: value.user!.uid,
        email: value.user!.email,status: 1,onSuccess: (){
          Navigator.pushReplacementNamed(context, home);
            });
      });


   emit(LoginSocialAuthStateSuccess());

    } catch (e) {

      loadLoginGoogle=false;
      emit(LoginSocialAuthStateError());
    }
  }

  bool loadFaceLogin=false;
  signInWithFacebook({context}) async {
    print("strt");
    loadFaceLogin=true;
   emit(LoginFaceAuthStateLoad());
    try {
      // Trigger the authentication flow
      final LoginResult loginResult=    await FacebookAuth.instance.login(permissions:["email","public_profile"]);

      if(loginResult.status == LoginStatus.success){
        print("vccccccccc${loginResult.accessToken!.token}");
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
        FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value){

          registerUser(endPoint: loginSocialPoint,fullName: value.user!.displayName,userName: value.user!.uid,
              email: value.user!.email,status: 2,onSuccess: (){
                Navigator.pushReplacementNamed(context, home);
              });

        });

        emit(LoginFaceAuthStateSuccess());
      }else{

        loadFaceLogin=false;

        emit(LoginFaceAuthStateError());
      }




    } catch (e) {
      loadFaceLogin=false;
      print("vccccccccc${e.toString()}");
      emit(LoginFaceAuthStateError());
    }
  }
  Future<void> logOut({context,onSuccess,onError}) async {

    await FirebaseAuth.instance.signOut().then((value){

    }).onError((error, stackTrace){

    });
  }
}
