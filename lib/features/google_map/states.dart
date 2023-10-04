part of 'bloc.dart';

class GoogleMapState {}

final class GoogleMapInitial extends GoogleMapState {}

class LoadingGoogleMapState extends GoogleMapState {}

class SuccessGoogleMapState extends GoogleMapState {
  double long;
  double latit;
  String streatName;
  SuccessGoogleMapState(this.latit, this.long, this.streatName);
}

class FailGoogleMapState extends GoogleMapState {}

class LoadingAddnewLocationState extends GoogleMapState {}

class SuccessAddnewLocationState extends GoogleMapState {
  String message;
  SuccessAddnewLocationState(this.message);
}

class FailAddnewLocationState extends GoogleMapState {
  String message;
  FailAddnewLocationState(this.message);
}

class LoadingGetLocation extends GoogleMapState {}

class SuccessGetLocation extends GoogleMapState {
  final double lat;
  final double long;
  final String streatName;

  SuccessGetLocation(
    this.lat,
    this.long,
    this.streatName,
  );
}

class FailGetLocation extends GoogleMapState {}

class SuccessGetEditLocation extends GoogleMapState {
  final double lat;
  final double long;
  final String streatName;

  SuccessGetEditLocation(
    this.lat,
    this.long,
    this.streatName,
  );
}

class FailGetEditLocation extends GoogleMapState {}

class ChangeTypeState extends GoogleMapState {}

class LoginState {
  final String emailAddress;
  final String password;

  LoginState({
    emailAddress,
    password,
  })  : emailAddress = '',
        password = '';

  LoginState copyWith({emailAddress, password, bool? isSubmitting}) {
    return LoginState(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
    );
  }
}
