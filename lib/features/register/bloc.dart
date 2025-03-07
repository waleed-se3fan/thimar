import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_thumara/core/utilities/api.dart';
import 'package:salla_thumara/data/cities.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'states.dart';
part 'events.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<GetRegisterDataEvent>(getRegisterData);
    on<CountDownTimerApearEvent>(activate);
    on<CountDownTimerDisapearEvent>(deactivate);
    on<EmailVerificationEvent>(emailVerification);
    on<ChoiseCountryEvent>(choiseCity);
    on<CitySelectorEvent>(citySelector);
  }
  /*All Register variables*/

  final formKey = GlobalKey<FormState>();
  final registernameController = TextEditingController();
  final registerphoneController = TextEditingController();
  final registerpasswordController = TextEditingController();
  final registerconfirmpasswordController = TextEditingController();
  final otpVerificationCode = TextEditingController();
  final controller = CountDownController();

  static String? cityValue;
  static String? cityId;
  citySelector(CitySelectorEvent event, Emitter<RegisterState> emit) {
    print(cityValue);
    emit(CitySelectorState(cityValue!));
  }

  String? message;

  String? mess2;

  String? verificationMessage;

  /*get register data from api  */

  Future getRegisterData(
      GetRegisterDataEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());

    final FormState? form = formKey.currentState;

    if (form!.validate()) {
      try {
        var response =
            await Dio().post('${ApiClass.baseApi}client_register', data: {
          'fullname': registernameController.text,
          'password': registerpasswordController.text,
          'phone': registerphoneController.text,
          'gender': 'female',
          'password_confirmation': registerconfirmpasswordController.text,
          'city_id': event.city,
          'country_id': '1'
        });
        mess2 = response.data['message'];
        SharedPreferences sharedPref = await SharedPreferences.getInstance();

        sharedPref.setString('name', event.name);
        sharedPref.setString('phone', event.phone);
        sharedPref.setString('city', event.city);
        emit(RegisterSuccesState(mess2!));
        emit(NotValidateState());
      } on DioException catch (ex) {
        message = ex.response!.data['message'];
        emit(RegisterFailState(message!));
      }
    } else {
      emit(NotValidateState());
    }
  }

  /* activate and disactivate resend verification message */

  bool active = true;

  activate(CountDownTimerApearEvent event, Emitter<RegisterState> emit) {
    active = false;
    emit(CountDownTimerAppearState());
  }

  deactivate(CountDownTimerDisapearEvent event, Emitter<RegisterState> emit) {
    active = true;
    emit(CountDownTimerDisappearState());
  }

  /*Email verification */

  emailVerification(
      EmailVerificationEvent event, Emitter<RegisterState> emit) async {
    emit(VerificationLoadingState());
    emit(CountDownTimerAppearState());

    try {
      var respone = await Dio().post('${ApiClass.baseApi}verify', data: {
        'code': otpVerificationCode.text,
        'phone': event.phone,
        'device_token': 'test',
        'type': 'ios',
      });
      verificationMessage = respone.data['status'];
      emit(VerificationScuceesState(verificationMessage));
    } on DioException catch (ex) {
      verificationMessage = ex.response!.data['message'];

      emit(VerificationFailState(verificationMessage));
    }
  }

  // save data in shared_prefrences

  List<City> cities = [];

  Future<List<City>?> choiseCity(
      ChoiseCountryEvent event, Emitter<RegisterState> emit) async {
    emit(ChoiseCountryLoadingState());
    try {
      var response = await Dio().get('${ApiClass.baseApi}cities/1',
          options: Options(headers: {
            'Accept': 'application/json',
            'lang': 'ar',
            'Accept-Language': 'ar',
          }));

      var data = response.data['data'];
      for (int x = 0; x <= 4; x++) {
        cities.length == 5
            ? cities
            : cities.add(City(data[x]['id'], data[x]['name']));
      }
      emit(ChoiseCountrySuccessState(cities));
      return cities;
    } catch (e) {
      emit(ChoiseCountryFailState());
      return null;
    }
  }
}
