part of 'bloc.dart';

class LoginEvent {}

class LoginToAppEvent extends LoginEvent {
  String phone;
  String password;
  LoginToAppEvent(this.phone, this.password);
}

class ForegtPasswordEvent extends LoginEvent {
  String phone;
  ForegtPasswordEvent(this.phone);
}

class LoginCountDownTimerApearEvent extends LoginEvent {}

class LoginCountDownTimerDisapearEvent extends LoginEvent {}

class LoginEmailVerificationEvent extends LoginEvent {
  String? phone;
  String? code;
  LoginEmailVerificationEvent(this.phone, this.code);
}

class CreateNewPasswordEvent extends LoginEvent {
  String phone;
  String code;
  String password;
  CreateNewPasswordEvent(this.phone, this.code, this.password);
}
