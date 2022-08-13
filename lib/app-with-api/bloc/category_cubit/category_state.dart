part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class GetCategoriesLoad extends CategoryState {}
class GetCategoriesSuccess extends CategoryState {}
class GetCategoriesError extends CategoryState {}


class GetSubCategoriesLoad extends CategoryState {}
class GetSubCategoriesSuccess extends CategoryState {}
class GetSubCategoriesError extends CategoryState {}

class ChangeValuCategory extends CategoryState {}
