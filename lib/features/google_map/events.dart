part of 'bloc.dart';

class GoogleMapEvent {}

class GetGoogleMapEvent extends GoogleMapEvent {}

class AddNewLocationEvent extends GoogleMapEvent {
  String type;
  String phone;
  String description;
  double latit;
  double long;
  String location;
  bool mainLocation;
  AddNewLocationEvent(
    this.type,
    this.phone,
    this.description,
    this.latit,
    this.long,
    this.location,
    this.mainLocation,
  );
}

class UpdateLocationEvent extends GoogleMapEvent {
  int id;
  String type;
  String description;
  String phone;
  double lat;
  double lng;
  String location;
  bool mainLocation;

  UpdateLocationEvent(
    this.id,
    this.type,
    this.description,
    this.phone,
    this.lat,
    this.lng,
    this.location,
    this.mainLocation,
  );
}

class ChangeTypeEvent extends GoogleMapEvent {
  String type;
  ChangeTypeEvent(this.type);
}

class GetLocationEvent extends GoogleMapEvent {
  double lat;
  double long;
  GetLocationEvent(this.lat, this.long);
}

class GetEditLocationEvent extends GoogleMapEvent {
  double lat;
  double long;
  GetEditLocationEvent(this.lat, this.long);
}

class ChangeMainAddressEvent extends GoogleMapEvent {
  bool check;
  ChangeMainAddressEvent(this.check);
}

class EditMainAddressEvent extends GoogleMapEvent {
  bool check;
  EditMainAddressEvent(this.check);
}
