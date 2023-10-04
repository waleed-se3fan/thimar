part of 'bloc.dart';

class RegisterEvent {}

class ValidateEvent extends RegisterEvent {}

class GetRegisterDataEvent extends RegisterEvent {
  String name;
  String phone;
  String city;
  GetRegisterDataEvent(this.name, this.phone, this.city);
}

class CountDownTimerApearEvent extends RegisterEvent {}

class CountDownTimerDisapearEvent extends RegisterEvent {}

class EmailVerificationEvent extends RegisterEvent {
  String? phone;
  EmailVerificationEvent(this.phone);
}

class ChoiseCountryEvent extends RegisterEvent {}

class CitySelectorEvent extends RegisterEvent {}

class SaveDataToSharedPref extends RegisterEvent {
  String name;
  String phone;
  String city;
  SaveDataToSharedPref(this.name, this.phone, this.city);
}

class GetDataFromSharedPref extends RegisterEvent {}
