import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:doniya/app-with-api/helpers/constants.dart';
import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  bool loadCategories = false;
  List<CategoryModel> categories = [];

  Future getCategories() async {
    loadCategories = true;
    categories = [];
    emit(GetCategoriesLoad());

    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + "/get-categories"));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      categories = [];
      jsonData.forEach((v) {
        categories.add(CategoryModel.fromJson(v));
      });
      loadCategories = false;
      emit(GetCategoriesSuccess());
    } else {
      print(response.statusCode);
      loadCategories = false;
      emit(GetCategoriesError());
    }
  }


  bool loadSubCategories = false;
  List<SubCategoryResponse> SubCategories = [];
  getSubCategoryByCatId({catId,cuntry}) async {
    loadSubCategories = true;
    SubCategories = [];
    emit(GetSubCategoriesLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "/subCategories-By-CategId"));
    request.fields.addAll({'id': catId.toString(), 'cuntry': cuntry});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      SubCategories = [];
      jsonData.forEach((v) {
        SubCategories.add(SubCategoryResponse.fromJson(v));
      });
      loadSubCategories = false;
      emit(GetSubCategoriesSuccess());
    } else {

      print(response.statusCode);
      loadSubCategories = false;
      emit(GetSubCategoriesError());
    }
  }
  CategoryModel? currentCategory;
  void changeValueDrop(value) {
    currentCategory =value;
    emit(ChangeValuCategory());

  }


  SubCategoryResponse? subCategoryResponse;
  void changeValueDropSubCategoryResponse(value) {
    subCategoryResponse =value;


    emit(ChangeValuCategory());

  }
}
