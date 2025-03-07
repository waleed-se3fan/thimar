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

class SuccessChangeMainAddressState extends GoogleMapState {
  final bool check;
  SuccessChangeMainAddressState(this.check);
}

class SuccessEditMainAddressState extends GoogleMapState {
  final bool check;
  SuccessEditMainAddressState(this.check);
}

class LoadingEditLocationState extends GoogleMapState {}

class SuccessEditLocationState extends GoogleMapState {
  String message;
  SuccessEditLocationState(this.message);
}

class FailEditLocationState extends GoogleMapState {
  String message;
  FailEditLocationState(this.message);
}
