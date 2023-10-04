part of 'bloc.dart';

class RegisterState {}

class RegisterInitial extends RegisterState {}

class ValidateState extends RegisterState {}

class GetRegisterDataState extends RegisterState {
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;
  GetRegisterDataState(
      this.name, this.phone, this.password, this.confirmPassword);
}

class RegisterSuccesState extends RegisterState {
  final String state;
  RegisterSuccesState(this.state);
}

class RegisterLoadingState extends RegisterState {}

class RegisterFailState extends RegisterState {
  final String state;
  RegisterFailState(this.state);
}

class CountDownTimerAppearState extends RegisterState {}

class CountDownTimerDisappearState extends RegisterState {}

class VerificationLoadingState extends RegisterState {}

class VerificationScuceesState extends RegisterState {
  String? message;
  VerificationScuceesState(this.message);
}

class VerificationFailState extends RegisterState {
  String? message;
  VerificationFailState(this.message);
}

class ChoiseCountryLoadingState extends RegisterState {}

class ChoiseCountrySuccessState extends RegisterState {
  List<City>? cities;
  ChoiseCountrySuccessState(this.cities);
}

class ChoiseCountryFailState extends RegisterState {}

class NotValidateState extends RegisterState {}

class CitySelectorState extends RegisterState {
  String city;
  CitySelectorState(this.city);
}

class NullCitySelectorState extends RegisterState {}
