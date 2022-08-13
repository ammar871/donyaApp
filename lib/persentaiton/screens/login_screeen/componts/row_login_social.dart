import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/providers/auth_providers.dart';
import 'package:flutter/cupertino.dart';

import 'button_social.dart';

class RowLoginSocial extends StatelessWidget {
  const RowLoginSocial({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonSocial(icon: "assets/icons/google.svg",onPress: (){
          AuthProviders.getInItRead(context).loginWithGoogle(context: context
              ,success: (){
                Navigator.of(context).pushReplacementNamed(home);
              },onError: (){

              });
        },),
        const SizedBox(width: 20,),
        ButtonSocial(icon: "assets/icons/face.svg",onPress: (){
          AuthProviders.getInItRead(context).signInWithFacebook(
              onError: (){},
              context: context,
              onSuccess: (){
                print("shhhhhhhhhhhh");
                Navigator.of(context).pushReplacementNamed(home);
              }
          );

          print("face");
        },),
        const SizedBox(width: 20,),
        ButtonSocial(icon: "assets/icons/twiter.svg",onPress: (){

          print("twiter");
        },)

      ],
    );
  }
}