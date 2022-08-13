import 'dart:convert';

import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/models/add_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../../helpers/conatans.dart';
import '../../helpers/functions.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  static AddCubit get(context) => BlocProvider.of<AddCubit>(context);

  bool loadAddAdd = false;

  Future addAdd(
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
      onSuccess,
      context,
      homeCategory,
      subCategory}) async {
    loadAddAdd = true;
    emit(AddAddsLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + "/add-adds"));
    request.fields.addAll({
      'CategoryId': categoryId.toString(),
      'Title': title,
      'Desc': desc,
      'Phone': phone.toString(),
      'PhoneWhats': phoneWhats.toString(),
      'Country': country,
      'lat': lat.toString(),
      'lang': lang.toString(),
      'IsImage': "$isImage",
      'token': tokenFCM,
      'Status': status.toString(),
      'Images': images,
      'AdvertiserName': nameAvertiser,
      'address': address,
      'UserId': currentUser.id!,
      'HomeCategory': homeCategory,
      'SubCategory': subCategory
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAddAdd = false;

      onSuccess();
      Navigator.pushNamed(context, categoAdds);
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم اضافة الاعلان");
      getAllAdds();
      emit(AddAddsSuccess());
    } else {
      loadAddAdd = false;
      print(response.statusCode);
      emit(AddAddsError());
    }
  }

  bool loadUpdate = false;

  updateAdd({addModel, onSuccess, context}) async {
    loadUpdate = true;

    emit(UpdateAddsLoad());
    var headers = {'Authorization': token};

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/update-my-add'));

    request.fields.addAll({
      'CategoryId': addModel.categoryId.toString(),
      'Title': addModel.title!,
      'Desc': addModel.desc!,
      'Phone': addModel.phone.toString(),
      'PhoneWhats': addModel.phoneWhats.toString(),
      'Country': addModel.country.toString(),
      'lat': addModel.lat.toString(),
      'lang': addModel.lang.toString(),
      'Images': addModel.images!,
      'token': tokenFCM,
      'AdvertiserName': addModel.advertiserName.toString(),
      'UserId': addModel.userId.toString(),
      'IsImage': '${addModel.isImage}',
      'Status': addModel.status.toString(),
      'address': addModel.address!,
      'HomeCategory': addModel.homeCategory.toString(),
      'SubCategory': addModel.subCategory!,
      'id': addModel.id.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      // String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      // printFunction(jsonData);
      loadUpdate = false;
      onSuccess();
      Navigator.pushNamed(context, categoAdds);
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم تعديل الاعلان");
      getAllAdds();

      emit(UpdateAddsSuccess());
    } else {
      loadUpdate = false;
      print(response.statusCode);
      emit(UpdateAddsError());
    }
  }

  bool loadDeleteAdd = false;

  deleteAdd({id, onSuccess, context}) async {
    loadDeleteAdd = true;
    emit(DeleteAddsLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/delete-add'));
    request.fields.addAll({'id': id.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      loadDeleteAdd = false;
      // Navigator.pushNamed(context, categoAdds);
      Navigator.pop(context);
      HelperFunction.slt.notifyUser(
          color: Colors.green, context: context, message: "تم حذف الاعلان");
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
  List<bool> imagesLoaded = [];

  deleteImage({image}) {
    imagesString.remove(image);
    emit(DeleteImageLoad());
  }

  bool loadImage = false;

  Future<dynamic> uploadImage(file,{isAdds=false}) async {

    loadImage = true;
    emit(UploadImageLoad());
    const url = baseUrl + "/image/upload";
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var multipartFile = await http.MultipartFile.fromPath(
      "file",
      file.path,
    );
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    var postBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {

      if(isAdds){
        Future.delayed(Duration(milliseconds: 3),(){
          imagesString.add(postBody.body.toString());
          print(postBody.body.toString()+"upload");
        });

      }else{
        imagesString.add(postBody.body.toString());
        print(postBody.body.toString()+"upload");
        loadImage = false;
      }


      emit(UploadImageSuccess(postBody.body.toString()));

      //update profile

    } else {
      loadImage = false;
      emit(UploadImageError());
      return "a.jpg";
    }
  }



  Future<dynamic> uploadMultiImages(file) async {

    loadImage = true;
    emit(UploadImageLoad());
    const url = baseUrl + "/image/upload";
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var multipartFile = await http.MultipartFile.fromPath(
      "file",
      file.path,
    );
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    var postBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {


      if(!imagesString.contains(postBody.body.toString())){
        imagesString.add(postBody.body.toString());
        print(postBody.body.toString()+"upload");
      }



      loadImage = false;
      emit(UploadImageSuccess(postBody.body.toString()));

      //update profile

    } else {
      loadImage = false;
      emit(UploadImageError());
      return "a.jpg";
    }
  }

  List<AddModel> adds = [];
  bool loadAdds = false;

  getAdds({categoryId,cuntry}) async {
    adds = [];
    List<AddModel> newAdds = [];
    loadAdds = true;
    emit(GetAddsLoad());

    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + "/get-adds"));
    request.fields.addAll({'categoryId': categoryId.toString(), 'cuntry':cuntry});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      adds = [];
      newAdds=[];
      jsonData.forEach((v) {
        newAdds.add(AddModel.fromJson(v));
      });
      adds = newAdds.reversed.toList();
      loadAdds = false;
      emit(GetAddsSuccess());
    } else {
      print(response.statusCode);
      loadAdds = false;
      emit(GetAddsError());
    }
  }

  ResponseAdd? responseAdd;
  bool loadAllAdd = false;
  List<AddModel> myCurrentAdds = [];

  getAllAdds() async {
    loadAllAdd = true;
    emit(GetAllAddsLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + '/get-my-adds'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      responseAdd = ResponseAdd.fromJson(jsonData);

      printFunction(
          "responseAdd!.currentAdds!.length${responseAdd!.currentAdds!.length}");
      emit(GetAllAddsSuccess());
    } else {
      print(response.statusCode);
      emit(GetAllAddsError());
    }
  }

  List<AddModel> searchAddsList = [];
  bool loadSearchAdds = false;

  searchAdds({nameAdd, coutry}) async {
    loadSearchAdds = true;
    searchAddsList = [];
    emit(SearchAddsLoad());
    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + '/searsh-my-adds'));
    request.fields.addAll({'nameAdd': nameAdd, 'cuntry': coutry});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      searchAddsList = [];
      jsonData.forEach((v) {
        searchAddsList.add(AddModel.fromJson(v));
      });
      loadSearchAdds = false;
      emit(SearchAddsSuccess());
    } else {
      print(response.statusCode);
      loadSearchAdds = false;
      emit(SearchAddsError());
    }
  }






  //==============pagination

  AddPagination? addsPagination;
  List<AddModel> newList = [];

  getAddsPagination({country, catId, page}) async {
    loadAdds = true;
    newList = [];
    emit(GetAllAddsLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/get-adds-page-byId'));

    request.fields.addAll({
      'Page': page.toString(),
      'itemsPerPage': '10',
      'id': catId.toString(),
      'cuntry': country
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      addsPagination = AddPagination.fromJson(jsonData);

      newList.addAll(addsPagination!.items!);

      loadAdds = false;

      emit(GetAddsSuccess());
    } else {
      print(response.reasonPhrase);
      loadAdds = false;
      emit(GetAddsError());
    }
  }

  // pagination
  bool loadingPage = false;

  pagination({catId, page,country}) async {

    loadingPage = true;
    emit(PaginationAddsLoad());

    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + '/get-adds-page-byId'));

    request.fields.addAll({
      'Page': page.toString(),
      'itemsPerPage': '10',
      'id': catId.toString(),
      'cuntry': country
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      addsPagination = AddPagination.fromJson(jsonData);

      newList.addAll(addsPagination!.items!);

      print(newList.length.toString()+"page");

      loadingPage = false;

      emit(PaginationAddsSuccess());
    } else {

      loadingPage = false;

      printFunction("errrrrrrrrrror");
      emit(PaginationAddsError());
    }



  }




}

class UploadImage{
  final String image;
  final bool loaded;
  final bool loading;

  UploadImage({required this.image, required this.loaded, required this.loading});
}