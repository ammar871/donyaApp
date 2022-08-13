part of 'profession_cubit.dart';

@immutable
abstract class ProfessionState {}

class ProfessionInitial extends ProfessionState {}

class LoginLoad extends ProfessionState {}
class LoginSuccess extends ProfessionState {

 final ResponseProfessional responseProfessional;

  LoginSuccess(this.responseProfessional);
}
class LoginError extends ProfessionState {
 final String message;

 LoginError(this.message);
}

// get Data
class GetProfessionsLoad extends ProfessionState {}
class GetProfessionsSuccess extends ProfessionState {

 final List<Profession> professions;

 GetProfessionsSuccess(this.professions);
}
class GetProfessionsError extends ProfessionState {
 final String message;

 GetProfessionsError(this.message);
}


//
//delete add
class DeleteAddsLoad extends ProfessionState {}
class DeleteAddsSuccess extends ProfessionState {}
class DeleteAddsError extends ProfessionState {}

// get Data
class AddProfessionLoad extends ProfessionState {}
class AddProfessionSuccess extends ProfessionState {
 AddProfessionSuccess();
}
class AddProfessionError extends ProfessionState {
 final String message;
 AddProfessionError(this.message);
}

//
class GetCategoriesLoad extends ProfessionState {}
class GetCategoriesSuccess extends ProfessionState {}
class GetCategoriesError extends ProfessionState {}

class ChangeValuCategory extends ProfessionState {}


//update


class UpdateAddsLoad extends ProfessionState {}
class UpdateAddsSuccess extends ProfessionState {}
class UpdateAddsError extends ProfessionState {}

class DeleteImageLoad extends ProfessionState {}





//update


class ForgetPassLoad extends ProfessionState {}
class ForgetPassSuccess extends ProfessionState {}
class ForgetPassError extends ProfessionState {}
