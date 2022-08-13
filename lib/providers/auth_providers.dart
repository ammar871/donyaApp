import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthProviders extends ChangeNotifier {
  static AuthProviders getInItWatch(BuildContext context) {
    return context.watch<AuthProviders>();
  }

  static AuthProviders getInItRead(BuildContext context) {
    return context.read<AuthProviders>();
  }

  late String verificationId;

  Future<void> submitPhoneNumber(BuildContext context, String phoneNumber,
      {onSuccss}) async {
    showLoadingDialog(context);
    notifyListeners();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        print('codeSent');
        print(verificationId + "");
        this.verificationId = verificationId;
        pop(context);
        onSuccss();

        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verificationCompleted");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    // emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken, {onSuccss}) {
    print('codeSent');
    print(verificationId + "");
    this.verificationId = verificationId;

    onSuccss();
    notifyListeners();
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode, BuildContext context,
      {onSuccsse, onError}) async {
    showLoadingDialog(context);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      pop(context);
      onSuccsse();

      notifyListeners();
      // emit(PhoneOTPVerified());
    } catch (error) {
      print("eeeeeeeeeeeee$error");
      pop(context);
      onError();
      notifyListeners();
      // emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
      // emit(PhoneOTPVerified());
    } catch (error) {
      notifyListeners();
      // emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> loginWithGoogle({context, success, onError}) async {
    showLoadingDialog(context);
    notifyListeners();
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      pop(context);
      success();

      notifyListeners();
    } catch (e) {
      pop(context);
      onError();
      notifyListeners();
    }
  }

  signInWithFacebook({context, onSuccess, onError}) async {
    print("strt");
    showLoadingDialog(context);
    notifyListeners();
    try {
      // Trigger the authentication flow
   final LoginResult loginResult=    await FacebookAuth.instance.login(permissions:["email"]);

   if(loginResult.status == LoginStatus.success){
     print("vccccccccc${loginResult.accessToken!.token}");
     final OAuthCredential facebookAuthCredential =
     FacebookAuthProvider.credential(loginResult.accessToken!.token);
     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
     pop(context);
     onSuccess();
     notifyListeners();

   }else{
     print(loginResult.status);
   }




    } catch (e) {
      print("errrrrrrrrrrrrrrrrrr  ${e.toString()}");
      pop(context);
      onError();
      notifyListeners();
    }
  }
  Future<void> logOut({context,onSuccess,onError}) async {
    showLoadingDialog(context);
    await FirebaseAuth.instance.signOut().then((value){
      pop(context);
      onSuccess();
      notifyListeners();
    }).onError((error, stackTrace){
      pop(context);
      onError();
      notifyListeners();
    });
  }
// loginWithFacebook(BuildContext context){
//   showLoadingDialog(context);
//   FacebookAuth.instance.login(
//       permissions: ["public_profile", "email"]).then((value) {
//     FacebookAuth.instance.getUserData().then((userData) {
//
//       });
//     });
//
// }
}
