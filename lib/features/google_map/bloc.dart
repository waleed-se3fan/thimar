import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salla_thumara/features/login/bloc.dart';
part 'events.dart';
part 'states.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc() : super(GoogleMapInitial()) {
    on<GoogleMapEvent>((event, emit) {});
    on<GetGoogleMapEvent>(getCurrentLocation);
    on<AddNewLocationEvent>(addNewLocation);
    on<UpdateLocationEvent>(updateAddress);
    on<ChangeTypeEvent>(changeType);
    on<ChangeMainAddressEvent>(changeMainAddress);
    on<GetLocationEvent>(getLocation);
    on<GetEditLocationEvent>(getEditLocation);
    on<EditMainAddressEvent>(editMainAddress);
  }

  //double? editLat;
  //double? editlong;

  static String type = 'المنزل';
  static double? latit;
  static double? long;
  static String? streatName;
  bool isHome = true;

  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  //////////////////////////////////////////////////////////////////
  int editType = 0;
  // TextEditingController editPhoneController = TextEditingController();
  // TextEditingController editDescriptionController = TextEditingController();

  String? editPhoneController;
  String? editDescriptionController;

  final x = TextEditingController();
  //String? editStreatName;

  Future getCurrentLocation(
      GetGoogleMapEvent event, Emitter<GoogleMapState> emit) async {
    emit(LoadingGoogleMapState());
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied &&
        permission == LocationPermission.deniedForever) {
      emit(LoadingGoogleMapState());
    } else {
      try {
        Position location = await Geolocator.getCurrentPosition();
        latit = location.latitude;
        long = location.longitude;
        List<Placemark> x = await GeocodingPlatform.instance
            .placemarkFromCoordinates(latit!, long!);
        streatName = '${x[0].locality} _ ${x[0].subAdministrativeArea}';
        print('=--=-=-=-=-=-=  $latit   $long    $streatName');

        // List<Addresses> lo = AddressesBloc.myAddresses!
        //     .where((element) => element.isDefault.toString().contains('true'))
        //     .toList();

        // print(lo[0].location);

        emit(SuccessGoogleMapState(latit!, long!, streatName!));
      } catch (e) {
        emit(FailGoogleMapState());
      }
    }
  }

  getLocation(GetLocationEvent event, Emitter<GoogleMapState> emit) async {
    try {
      latit = event.lat;
      long = event.long;

      List<Placemark> x = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latit!, long!);

      streatName = '${x[0].locality} _ ${x[0].subAdministrativeArea}';

      emit(SuccessGetLocation(latit!, long!, streatName!));
    } on DioException catch (e) {
      e.error;
      emit(FailGetLocation());
    }
  }

  getEditLocation(
      GetEditLocationEvent event, Emitter<GoogleMapState> emit) async {
    try {
      latit = event.lat;
      long = event.long;

      List<Placemark> x = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latit!, long!);

      streatName = '${x[0].locality} _ ${x[0].subAdministrativeArea}';

      emit(SuccessGetEditLocation(latit!, long!, streatName!));
    } on DioException catch (e) {
      e.error;
      emit(FailGetEditLocation());
    }
  }

  Future addNewLocation(
      AddNewLocationEvent event, Emitter<GoogleMapState> emit) async {
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    emit(LoadingAddnewLocationState());
    try {
      if (event.phone == '') {
        emit(FailAddnewLocationState('رقم الجوال مطلوب'));
      } else if (event.description == '') {
        emit(FailAddnewLocationState('الوصف مطلوب'));
        // ignore: unnecessary_null_comparison
      } else if (event.location == null) {
        emit(FailAddnewLocationState('الموقع علي الخريطة مطلوب'));
      } else {
        var response = await Dio().post(
            'https://thimar.amr.aait-d.com/public/api/client/addresses',
            options: Options(
                headers: {'Authorization': 'Bearer ${LoginBloc.token}'}),
            data: {
              'type': event.type,
              'phone': event.phone,
              'description': event.description,
              'location': event.location,
              'lat': event.latit,
              'lng': event.long,
              'is_default': event.mainLocation ? '0' : '1',
            });

        List<Placemark> x = await GeocodingPlatform.instance
            .placemarkFromCoordinates(event.latit, event.long);
        streatName = '${x[0].locality} _ ${x[0].subAdministrativeArea}';
        print('ssssssssssssssssssssssssssssssssssssssssss');
        emit(SuccessAddnewLocationState(response.data['message']));
      }
    } on DioException catch (e) {
      emit(FailAddnewLocationState(e.response!.data['message'].toString()));
      print('ffffffffffffffffffffffffffffffffffffffff');
      //print(e.!.data['message']);
    }
  }

  changeType(ChangeTypeEvent event, Emitter<GoogleMapState> emit) {
    type = event.type;
    emit(ChangeTypeState());
  }

  Future updateAddress(
      UpdateLocationEvent event, Emitter<GoogleMapState> emit) async {
    emit(LoadingEditLocationState());
    print('iiiiiiiiiiiiiiiiiiiiiiiii');
    try {
      var response = await Dio().put(
          'https://thimar.amr.aait-d.com/public/api/client/addresses/${event.id}',
          data: {
            'type': event.type,
            'lng': event.lng,
            'lat': event.lat,
            'location': event.location,
            'description': event.description,
            'phone': event.phone,
            'is_default': event.mainLocation ? '0' : '1',
          },
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

      List<Placemark> x = await GeocodingPlatform.instance
          .placemarkFromCoordinates(event.lat, event.lat);
      streatName = '${x[0].locality} _ ${x[0].subAdministrativeArea}';
      emit(SuccessEditLocationState(response.data['message']));
      print('sssssssssssssssssssssssss');
    } on DioException catch (e) {
      e.error;
      emit(FailEditLocationState(e.response!.data['message'].toString()));

      print('fffffffffffffffffffffffff');
    }
  }

  bool mainAddress = false;
  changeMainAddress(
      ChangeMainAddressEvent event, Emitter<GoogleMapState> emit) {
    mainAddress = event.check;
    emit(SuccessChangeMainAddressState(mainAddress));
  }

  bool editAddress = false;
  editMainAddress(EditMainAddressEvent event, Emitter<GoogleMapState> emit) {
    editAddress = event.check;
    emit(SuccessEditMainAddressState(editAddress));
  }
}
