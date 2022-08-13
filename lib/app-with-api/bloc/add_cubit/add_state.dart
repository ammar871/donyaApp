part of 'add_cubit.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}



class GetAddsLoad extends AddState {}
class GetAddsSuccess extends AddState {}
class GetAddsError extends AddState {}



class GetAllAddsLoad extends AddState {}
class GetAllAddsSuccess extends AddState {}
class GetAllAddsError extends AddState {}
//add

class AddAddsLoad extends AddState {}
class AddAddsSuccess extends AddState {}
class AddAddsError extends AddState {}

//delete add
class DeleteAddsLoad extends AddState {}
class DeleteAddsSuccess extends AddState {}
class DeleteAddsError extends AddState {}

//update


class UpdateAddsLoad extends AddState {}
class UpdateAddsSuccess extends AddState {}
class UpdateAddsError extends AddState {}


//search


class SearchAddsLoad extends AddState {}
class SearchAddsSuccess extends AddState {}
class SearchAddsError extends AddState {}

//
// uploadImage
class UploadImageLoad extends AddState {}
class UploadImageSuccess extends AddState {
  final String image;

  UploadImageSuccess(this.image);
}
class UploadImageError extends AddState {


  UploadImageError();
}

class DeleteImageLoad extends AddState {}


//pagination
//pagination
class PaginationAddsLoad extends AddState {}
class PaginationAddsSuccess extends AddState {}
class PaginationAddsError extends AddState {}