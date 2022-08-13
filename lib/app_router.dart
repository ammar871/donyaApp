import 'package:doniya/app-with-api/ui/auth_with_api_screens/login_api_screen.dart';
import 'package:doniya/app-with-api/ui/profession_screen/add_profession_screen/add_profession_screen.dart';
import 'package:doniya/app-with-api/ui/profession_screen/home_prof/home_profession.dart';
import 'package:doniya/app-with-api/ui/profession_screen/my_adds_screen/my_adds_prof_screen.dart';
import 'package:doniya/app-with-api/ui/profession_screen/profession_auth/profession_auth.dart';
import 'package:doniya/app-with-api/ui/profession_screen/profession_screen.dart';
import 'package:doniya/persentaiton/screens/adds/add_adds_screen.dart';
import 'package:doniya/persentaiton/screens/adds/categories_adds.dart';
import 'package:doniya/persentaiton/screens/auction/auction_screen.dart';
import 'package:doniya/persentaiton/screens/categories_screen/categories_screen.dart';
import 'package:doniya/persentaiton/screens/change_lang_screen/change_lang_screen.dart';
import 'package:doniya/persentaiton/screens/contriler.dart';
import 'package:doniya/persentaiton/screens/home_screen/home_screen.dart';
import 'package:doniya/persentaiton/screens/login_screeen/login_screen.dart';
import 'package:doniya/persentaiton/screens/maintenance/maintenance_screen.dart';
import 'package:doniya/persentaiton/screens/maps/select_map_screen.dart';
import 'package:doniya/persentaiton/screens/adds/my_adds_screen.dart';

import 'package:doniya/persentaiton/screens/all_adds/all_adds_screen.dart';
import 'package:doniya/persentaiton/screens/otp_screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'biussins_logic/bloc_auth/cubit/phone_auth_cubit.dart';
import 'helpers/conatans.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Contriller(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) =>
          LoginApiScreen(),
        );
      case map_screen:
        return   MaterialPageRoute(
          builder: (_) =>  SelectMapScreen(),
        );


      case categAuction:
        return MaterialPageRoute(
          builder: (_) => const AuctionScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case categMaintence:
        return MaterialPageRoute(
          builder: (_) => MaintenanceScreen(),
        );
      case subhome:
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(),
        );
   case categoAdds:
        return MaterialPageRoute(
          builder: (_) => CategoriesAdds(),
        );


      case otpScreen:
        return MaterialPageRoute(
          builder: (_) =>
              OtpScreen(),
        );

      case loginApi:
        return MaterialPageRoute(
          builder: (_) =>
              LoginApiScreen(),
        );


      case profession_splash:
        return MaterialPageRoute(
          builder: (_) =>
              ProfessionScreen(),
        );

      case perfession_login:
          return MaterialPageRoute(
            builder: (_) =>
                ProfessionAuth(),
          );
      case home_prof:
        return MaterialPageRoute(
          builder: (_) =>
              HomeProfession(),
        );
      case langScreen:
        return MaterialPageRoute(
          builder: (_) =>
              ChangeLangScreen(),
        );
      // case add_add_profession:
      //
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         AddProfessionScreen(),
      //   );

      case my_adds_prof:

        return MaterialPageRoute(
          builder: (_) =>
              MyAddsProfScreen(),
        );
    }
  }
}