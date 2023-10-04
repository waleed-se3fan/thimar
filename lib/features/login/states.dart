part of 'bloc.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccesState extends LoginState {
  String message;
  LoginSuccesState(this.message);
}

class LoginFailedState extends LoginState {
  String message;
  LoginFailedState(this.message);
}

class ForgitPasswordLoadingState extends LoginState {}

class ForgitPasswordSuccesState extends LoginState {
  String? message;
  ForgitPasswordSuccesState(this.message);
}

class LoginCountDownTimerAppearState extends LoginState {}

class LoginCountDownTimerDisappearState extends LoginState {}

class ForgetPasswordFailState extends LoginState {
  String message;
  ForgetPasswordFailState(this.message);
}

class LoginVerificationLoadingState extends LoginState {}

class LoginVerificationScuceesState extends LoginState {
  String? message;
  LoginVerificationScuceesState(this.message);
}

class LoginVerificationFailState extends LoginState {
  String? message;
  LoginVerificationFailState(this.message);
}

class CreateNewPasswordLoadingState extends LoginState {}

class CreateNewPasswordSuccsessState extends LoginState {
  String? message;
  CreateNewPasswordSuccsessState(this.message);
}

class CreateNewPasswordFailState extends LoginState {
  String? message;
  CreateNewPasswordFailState(this.message);
}

class PasseordNotMatchState extends LoginState {
  String? message;
  PasseordNotMatchState(this.message);
}

class NotValidateState extends LoginState {}
