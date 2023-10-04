import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'events.dart';
part 'states.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc() : super(GoogleMapInitial()) {
    on<GoogleMapEvent>((event, emit) {});
    on<GetGoogleMapEvent>(getCurrentLocation);
    on<AddNewLocationEvent>(addNewLocation);
    on<UpdateLocationEvent>(updateAddress);
    on<ChangeTypeEvent>(changeType);
    on<GetLocationEvent>(getLocation);
    on<GetEditLocationEvent>(getEditLocation);
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
      } else if (event.location == null) {
        emit(FailAddnewLocationState('الموقع علي الخريطة مطلوب'));
      } else {
        var response = await Dio()
            .post('https://thimar.amr.aait-d.com/public/api/client/addresses',
                options: Options(headers: {
                  'Authorization':
                      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
                }),
                data: {
              'type': event.type,
              'phone': event.phone,
              'description': event.description,
              'location': event.location,
              'lat': event.latit,
              'lng': event.long,
              'is_default': '1',
            });
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
    try {
      await Dio().put(
          'https://thimar.amr.aait-d.com/public/api/client/addresses/${event.id}',
          data: {
            'type': event.type,
            'lng': event.lng,
            'lat': event.lat,
            'location': event.location,
            'description': event.description,
            'phone': event.phone
          },
          options: Options(headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
          }));
    } on DioException catch (e) {
      e.error;
      print('fffffffffffffffffffffffffffffffffffffffffffffff');
    }
  }
}
