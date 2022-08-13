import 'package:doniya/app-with-api/models/response_prof.dart';

import '../models/user_model.dart';

//https://donya.urapp.site

const url="https://donyagroup.urapp.site";
const baseUrl = url+"/api";
const baseUrl2 = url;
const baseUrlImages =url+"/images/";

const loginPoint = "/auth/confirm-Code";
const loginProf="/professional-login";
const registerPoint = "/auth/signup";
const loginSocialPoint = "/auth/google/login";
const getUserDetailsPoint = "/user/detail";
const updateUserDetailsPoint = "/user/update";
const checkUserNamePoint = "/auth/check-username";
const validatePoint = "/auth/validate";










String token = "";
String tokenFCM = "";
UserModel currentUser = UserModel();
ResponseProfessional currentProf = ResponseProfessional();
printFunction(message) {
  // ignore: avoid_print
  print(message);
}