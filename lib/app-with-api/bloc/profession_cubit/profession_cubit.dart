import 'dart:convert';

import 'package:doniya/app-with-api/models/category_profession.dart';
import 'package:doniya/app-with-api/models/response_prof.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/profession.dart';

part 'profession_state.dart';

class ProfessionCubit extends Cubit<ProfessionState> {
  ProfessionCubit() : super(ProfessionInitial());

  static ProfessionCubit get(context) =>
      BlocProvider.of<ProfessionCubit>(context);

  bool loadLogin = false;

  loginUser({email, pass}) async {
    loadLogin = true;
    emit(LoginLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + loginProf));
    request.fields.addAll({'phone': email, 'password': pass.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      ResponseProfessional userResponse =
          ResponseProfessional.fromJson(jsonData);

      currentProf = userResponse;

      // if(data['driver']!=null) currentUser.driver = Driver.fromJson(data['driver']);
      await saveDataProf();

      printFunction(userResponse.fullName);
      loadLogin = false;
      emit(LoginSuccess(userResponse));
    } else {
      loadLogin = false;
      printFunction("errrrrrrrrrror" + response.statusCode.toString());
      emit(LoginError("الحساب غير موجود"));
    }
  }

  bool loadData = false;
  List<Profession> professions = [];

  Future getProfessionsAdds({id}) async {
    loadData = true;
    professions = [];
    emit(GetProfessionsLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl2 + "/professions-adds-by-id"));
    request.fields.addAll({'id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      professions = [];
      jsonData.forEach((v) {
        professions.add(Profession.fromJson(v));
      });
      loadData = false;
      emit(GetProfessionsSuccess(professions));
    } else {
      print(response.statusCode);
      loadData = false;
      emit(GetProfessionsError("Error"));
    }
  }

  Future getMyProfessionsAdds() async {
    loadData = true;
    professions = [];
    emit(GetProfessionsLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl2 + '/professions-my-adds'));

    var headers = {'Authorization': token};

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      professions = [];
      jsonData.forEach((v) {
        professions.add(Profession.fromJson(v));
      });
      loadData = false;
      emit(GetProfessionsSuccess(professions));
    } else {
      print(response.statusCode);
      loadData = false;
      emit(GetProfessionsError("Error"));
    }
  }

  bool loadUpdate = false;

  updateAdd({addModel, onSuccess, context}) async {
    loadUpdate = true;

    emit(UpdateAddsLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2 + '/update-profession-add'));

    request.fields.addAll({
      'CategoryId': addModel.categoryId.toString(),
      'Title': addModel.title!,

      'Phone': addModel.phone.toString(),
      'PhoneWhats': addModel.phoneWhats.toString(),
      'Country': addModel.country.toString(),
      'lat': addModel.lat.toString(),
      'lang': addModel.lang.toString(),
      'Images': addModel.images!,
      'AdvertiserName': addModel.advertiserName.toString(),
      'UserId': addModel.userId.toString(),
      'IsImage': '${addModel.isImage}',
      'Status': addModel.status.toString(),
      'address': addModel.address!,

      'id': addModel.id.toString(),
      'token': tokenFCM,
      'userId': currentUser.id!,
      'desc': addModel.desc!
      //==

    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      // printFunction(jsonData);
      loadUpdate = false;
      onSuccess();

      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم تعديل الاعلان");
      getMyProfessionsAdds();

      emit(UpdateAddsSuccess());
    } else {
      loadUpdate = false;
      print(response.statusCode);
      emit(UpdateAddsError());
    }
  }

  bool loadAddAdd = false;

  Future addAddProfession(
      {address,
      categoryId,
      title,
      desc,
      phone,
      phoneWhats,
      country,
      lat,
      lang,
      images,
      nameAvertiser,
      isImage,
      status,
      token,
      onSuccess,
      context}) async {
    loadAddAdd = true;
    emit(AddProfessionLoad());

    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl2 + "/add-profession-add"));

    request.fields.addAll({
      'CategoryId': categoryId.toString(),
      'Title': title,
      'Phone': phone.toString(),
      'PhoneWhats': phoneWhats.toString(),
      'Country': country,
      'lat': lat.toString(),
      'lang': lang.toString(),
      'IsImage': "$isImage",
      'Status': status.toString(),
      'Images': images,
      'AdvertiserName': nameAvertiser,
      'address': address,
      //  ============
      'token': tokenFCM,
      'userId': currentUser.id!,
      'desc': desc
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAddAdd = false;

      onSuccess();
      // Navigator.pushNamed(context, categoAdds);
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم اضافة الاعلان");
      getMyProfessionsAdds();
      emit(AddProfessionSuccess());
    } else {
      loadAddAdd = false;
      print(response.statusCode);
      emit(AddProfessionError("error"));
    }
  }

  List<CategoryProfession> categoryProfessions = [];

  getCategoryProfessions() async {
    categoryProfessions = [];
    emit(GetCategoriesLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl2 + "/get-professions-category"));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      categoryProfessions = [];
      jsonData.forEach((v) {
        categoryProfessions.add(CategoryProfession.fromJson(v));
      });

      emit(GetCategoriesSuccess());
    } else {
      print(response.statusCode);
      // loadCategories = false;
      emit(GetCategoriesError());
    }
  }

  bool loadDeleteAdd = false;

  deleteAdd({id, onSuccess, context}) async {
    loadDeleteAdd = true;
    emit(DeleteAddsLoad());

    // var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl2 + '/delete-profession-add'));
    request.fields.addAll({'id': id.toString()});
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      loadDeleteAdd = false;
      // Navigator.pushNamed(context, categoAdds);
      pop(context);
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم حذف الاعلان");
      getMyProfessionsAdds();
      emit(DeleteAddsSuccess());
    } else {
      loadDeleteAdd = false;
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "لم يتم حذف الاعلان");
      print(response.statusCode);
      emit(DeleteAddsSuccess());
    }
  }

  List<String> imagesString = [];

  deleteImage({image}) {
    imagesString.remove(image);
    emit(DeleteImageLoad());
  }

  CategoryProfession? currentCategory;

  void changeValueDrop(value) {
    currentCategory = value;
    emit(ChangeValuCategory());
  }

  bool loadForget=false;
  ResponseProfessional? userResponse ;
  forgetPass({phone})async{
    loadForget=true;

    emit(ForgetPassLoad());
    var request = http.MultipartRequest('POST', Uri.parse(url+'/forget-pass'));
    request.fields.addAll({
      'phone': phone
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
       userResponse =
      ResponseProfessional.fromJson(jsonData);

       loadForget=false;
       emit(ForgetPassSuccess());

    }
    else {
    print(response.statusCode);
    loadForget=false;
    emit(ForgetPassError());
    }

  }
}
