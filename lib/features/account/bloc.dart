// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salla_thumara/data/freq_quistion.dart';
import 'package:salla_thumara/data/wallet.dart';

part 'events.dart';
part 'states.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>((event, emit) {});

    on<GetTermsEvent>(getTerms);
    on<ComplaintsAndSuggestionEvent>(addComplaintsAndSuggestion);
    on<GetFreqQuistionEvent>(getRepeatQuistion);
    on<CheckVisibilityEvent>(checkVisiblity);
    on<GetAboutAppEvent>(getAboutApp);
    on<EditPersonalDataEvent>(updatePersonalData);
    on<GetWalletEvent>(getWallet);
    on<ChargeWalletEvent>(chargeWallet);
  }
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  static XFile? image;
  final String streatName = '';
  final String imagePath = '';

  updatePersonalData(
      EditPersonalDataEvent event, Emitter<AccountState> emit) async {
    try {
      await Dio()
          .post('https://thimar.amr.aait-d.com/public/api/client/profile',
              data: {
                'image': XFile(
                    'https://thimar.amr.aait-d.com/public/dashboardAssets/images/backgrounds/avatar.jpg'),
                'fullname': event.fullname,
                'phone': event.phone,
                'city_id': event.cityId
              },
              options: Options(headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvbG9naW4iLCJpYXQiOjE2OTYwNjkxMDgsImV4cCI6MTcyNzYwNTEwOCwibmJmIjoxNjk2MDY5MTA4LCJqdGkiOiJGNURCbXF4QnVQVGEzbjRTIiwic3ViIjoxMDYzLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.FPeMTiLkccGn4qWTUvcyrc7QXZNsx4dsnkXCkp71wbc'
              }));
    } on DioException catch (e) {
      return e;
    }
  }

  getTerms(GetTermsEvent event, Emitter<AccountState> emit) async {
    emit(LoadingGetTermsState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/terms',
          options: Options(headers: {'Accept-Language': 'ar'}));
      String data = response.data['data']['terms'];
      emit(SuccessGetTermsState(data));
    } on DioException catch (e) {
      e.error;
      emit(FailGetTermsState());
    }
  }

  final suggestionNameController = TextEditingController();
  final suggestionPhoneController = TextEditingController();
  final suggestionContentontroller = TextEditingController();
  Future addComplaintsAndSuggestion(
      ComplaintsAndSuggestionEvent event, Emitter<AccountState> emit) async {
    emit(LoadingComplaintsAndSuggestionState());
    try {
      var response = await Dio()
          .post('https://thimar.amr.aait-d.com/public/api/contact', data: {
        'fullname': event.name,
        'phone': event.phoneName,
        'content': event.content
      });
      emit(SuccessComplaintsAndSuggestionState(response.data['message']));
    } on DioException catch (e) {
      emit(FailComplaintsAndSuggestionState(e.response!.data['message']));
    }
  }

  Future getRepeatQuistion(
      GetFreqQuistionEvent event, Emitter<AccountState> emit) async {
    emit(LoadingGetFreqQuistionState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/faqs',
          options: Options(headers: {'Accept-Language': 'ar'}));
      List data = response.data['data'];

      List<FrqQuistionModel> freqQuistion =
          data.map((e) => FrqQuistionModel.fromJson(e)).toList();
      emit(SuccessGetFreqQuistionState(freqQuistion));
    } catch (e) {
      emit(FailGetFreqQuistionState());
    }
  }

  checkVisiblity(CheckVisibilityEvent event, Emitter<AccountState> emit) {
    event.state = !event.state;
    emit(CheckVisibleState(event.state));
  }

  getAboutApp(GetAboutAppEvent event, Emitter<AccountState> emit) async {
    emit(LoadingGetAboutAppState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/about',
          options: Options(headers: {'Accept-Language': 'ar'}));
      String data = response.data['data']['about'];
      emit(SuccessGetAboutAppState(data));
    } on DioException catch (e) {
      e.error;
      emit(FailGetAboutAppState());
    }
  }

  getWallet(GetWalletEvent event, Emitter<AccountState> emit) async {
    emit(LoadingGetWalletState());

    try {
      var response =
          await Dio().get('https://thimar.amr.aait-d.com/public/api/wallet',
              options: Options(headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvbG9naW4iLCJpYXQiOjE2OTU4MTE1NjIsImV4cCI6MTcyNzM0NzU2MiwibmJmIjoxNjk1ODExNTYyLCJqdGkiOiJKQ0s3V1pCOFhvYkhjVFZnIiwic3ViIjoxMDQ0LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.sjEOy6NpiQtx8Uzwl7640HF4hzDEereCG95wTngXhrM'
              }));

      List data = response.data['data'];
      List<WalletModel> allWallet =
          data.map((e) => WalletModel.fromJson(e)).toList();
      num wallet = response.data['wallet'];

      emit(SuccessGetWalletState(allWallet, wallet));
    } on DioException catch (e) {
      emit(FailGetWalletState(e.response!.data));
    }
  }

  static final amountController = TextEditingController();
  chargeWallet(ChargeWalletEvent event, Emitter<AccountState> emit) async {
    emit(LoadingChargeWalletState());
    try {
      var response = await Dio()
          .post('https://thimar.amr.aait-d.com/public/api/wallet/charge',
              data: {'transaction_id': '1111', 'amount': event.amount},
              options: Options(headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvbG9naW4iLCJpYXQiOjE2OTU4MTE1NjIsImV4cCI6MTcyNzM0NzU2MiwibmJmIjoxNjk1ODExNTYyLCJqdGkiOiJKQ0s3V1pCOFhvYkhjVFZnIiwic3ViIjoxMDQ0LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.sjEOy6NpiQtx8Uzwl7640HF4hzDEereCG95wTngXhrM'
              }))
          .then((value) {
        add(GetWalletEvent());
      });

      emit(SuccessChargeWalletState(response.data['message']));
    } on DioException catch (e) {
      emit(FailChargetState(e.response!.data['message']));
    }
  }
}
