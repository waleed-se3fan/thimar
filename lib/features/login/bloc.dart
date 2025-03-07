// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salla_thumara/core/utilities/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'events.dart';
part 'states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginToAppEvent>(loginToApp);
    on<ForegtPasswordEvent>(forgetPassword);
    on<LoginCountDownTimerApearEvent>(activate);
    on<LoginCountDownTimerDisapearEvent>(deactivate);
    on<LoginEmailVerificationEvent>(checkCode);
    on<CreateNewPasswordEvent>(createNewPassword);
  }
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final forgetPasswordPhoneController = TextEditingController();
  final otpVerificationCode = TextEditingController();
  String? message;
  final formKey = GlobalKey<FormState>();
  final controller = CountDownController();

  final newPasswordController1 = TextEditingController();
  final newPasswordController2 = TextEditingController();

  static String? fullName;
  static String? phone;
  static String? image;
  static String? token;
  static String? city_name;

  static bool? islogin;
  Future loginToApp(LoginToAppEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      try {
        var response = await Dio().post('${ApiClass.baseApi}login',
            options: Options(headers: {
              'Accept': 'application/json',
              'lang': 'ar',
              'Accept-Language': 'ar',
            }),
            data: {
              'phone': event.phone,
              'password': event.password,
              'device_token': 'test',
              'type': 'ios',
              'user_type': 'client'
            });
        setData(response);

        message = response.data['status'];
        emit(LoginSuccesState(message!));
        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString('fullname', response.data['data']['fullname']);
        sharedPref.setString('phone', response.data['data']['phone']);
        sharedPref.setString('image', response.data['data']['image']);
        sharedPref.setString('token', response.data['data']['token']);
        sharedPref.setString(
            'city_name', response.data['data']['city']['name']);
        fullName = sharedPref.getString('fullname')!;
        phone = sharedPref.getString('phone')!;
        image = sharedPref.getString('image')!;
        token = sharedPref.getString('token')!;
        city_name = sharedPref.getString('city_name')!;

        loginPhoneController.clear();
        loginPasswordController.clear();
      } on DioException catch (ex) {
        message = ex.response!.data['message'];
        emit(LoginFailedState(message!));
      }
    } else {
      emit(NotValidateState());
    }
  }

  setData(Response response) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('fullname', response.data['data']['fullname']);
    sharedPref.setString('phone', response.data['data']['phone']);
    sharedPref.setString('image', response.data['data']['image']);
    sharedPref.setString('token', response.data['data']['token']);
    sharedPref.setString('city_name', response.data['data']['city']['name']);

//    city_name = sharedPref.getString('city_name')!;

    //   print(city_name);
  }

  static getData() async {
    final sharedPref = await SharedPreferences.getInstance();

    fullName = sharedPref.getString('fullname')!;
    phone = sharedPref.getString('phone')!;
    image = sharedPref.getString('image')!;
    token = sharedPref.getString('token')!;
    city_name = sharedPref.getString('city_name');

    print('************************************************');

    print(fullName);
    print(phone);
    print(image);
    print(token);
    print(city_name);
  }

  forgetPassword(ForegtPasswordEvent event, Emitter<LoginState> emit) async {
    emit(ForgitPasswordLoadingState());
    final FormState? form = formKey.currentState;

    if (form!.validate()) {
      try {
        var response =
            await Dio().post('${ApiClass.baseApi}forget_password', data: {
          'phone': event.phone,
        });

        message = response.data['message'];

        emit(ForgitPasswordSuccesState(message!));
      } on DioException catch (ex) {
        message = ex.response!.data['message'];
        emit(ForgetPasswordFailState(message!));
      }
    } else {
      emit(NotValidateState());
    }
  }

  /* activate and disactivate resend verification message */

  bool active = true;

  activate(LoginCountDownTimerApearEvent event, Emitter<LoginState> emit) {
    active = false;
    emit(LoginCountDownTimerAppearState());
  }

  deactivate(LoginCountDownTimerDisapearEvent event, Emitter<LoginState> emit) {
    active = true;
    emit(LoginCountDownTimerDisappearState());
  }

  /*Email verification */

  checkCode(LoginEmailVerificationEvent event, Emitter<LoginState> emit) async {
    emit(LoginVerificationLoadingState());
    emit(LoginCountDownTimerAppearState());

    try {
      var respone = await Dio().post('${ApiClass.baseApi}check_code', data: {
        'code': event.code,
        'phone': event.phone,
      });
      var verificationMessage = respone.data['message'];
      emit(LoginVerificationScuceesState(verificationMessage));
    } on DioException catch (ex) {
      var verificationMessage = ex.response!.data['message'];

      emit(LoginVerificationFailState(verificationMessage));
    }
  }

/* create new password */

  createNewPassword(
      CreateNewPasswordEvent event, Emitter<LoginState> emit) async {
    emit(CreateNewPasswordLoadingState());
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      if (newPasswordController1.text == newPasswordController2.text) {
        try {
          var respone = await Dio().post('${ApiClass.baseApi}reset_password',
              data: {
                'code': event.code,
                'phone': event.phone,
                'password': event.password
              });
          var verificationMessage = respone.data['message'];
          emit(CreateNewPasswordSuccsessState(verificationMessage));
        } on DioException catch (ex) {
          var verificationMessage = ex.response!.data['message'];

          emit(CreateNewPasswordFailState(verificationMessage));
        }
      } else {
        var varificationMessage = 'the password dosn,t match';
        emit(PasseordNotMatchState(varificationMessage));
      }
    } else {
      emit(NotValidateState());
    }
  }
}
