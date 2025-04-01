// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salla_thumara/data/freq_quistion.dart';
import 'package:salla_thumara/data/wallet.dart';
import 'package:salla_thumara/features/login/bloc.dart';
import 'package:salla_thumara/views/my_account_page/screens/paymob.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    on<EditPasswordEvent>(updatePassword);
    on<GetWalletEvent>(getWallet);
    on<ChargeWalletEvent>(chargeWallet);
    on<ChangeImageEvent>(changeImage);
    on<GetPolicyEvent>(getPolicy);
    on<PaymopEventEvent>(paymop);
  }
  final userNameController = TextEditingController(text: LoginBloc.fullName);
  final phoneController = TextEditingController(text: LoginBloc.phone);
  final passwordController = TextEditingController();

  final String streatName = '';
  final String imagePath = '';

  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  updatePersonalData(
      EditPersonalDataEvent event, Emitter<AccountState> emit) async {
    emit(LoadingUpdateProfileState());
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    try {
      print('sssssssssssssssssssssssssssss');

      var response = await Dio().post(
          'https://thimar.amr.aait-d.com/public/api/client/profile',
          data: FormData.fromMap({
            'image': MultipartFile.fromFileSync(event.image.path,
                filename: 'waleed'),
            'fullname': event.fullname,
            'phone': event.phone,
            'city_id': '12'
          }),
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print('object');
      setNewData(response);
      LoginBloc.getData();
      emit(SuccessUpdateProfileState());
    } on DioException catch (e) {
      return e;
    }
  }

  updatePassword(EditPasswordEvent event, Emitter<AccountState> emit) async {
    emit(LoadingEditPasswordState());
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    try {
      print('sssssssssssssssssssssssssssss');

      await Dio().put('https://thimar.amr.aait-d.com/public/api/edit_password',
          data: FormData.fromMap({
            'old_password': event.oldPassword,
            'password': event.newPassword,
          }),
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print('object');
      LoginBloc.getData();
      emit(SuccessEditPasswordState());
    } on DioException catch (e) {
      return e;
    }
  }

  setNewData(Response response) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('fullname', response.data['data']['fullname']);
    sharedPref.setString('image', response.data['data']['image']);
    sharedPref.setString('phone', response.data['data']['phone']);
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
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/wallet',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

      List data = response.data['data'];
      List<WalletModel> allWallet =
          data.map((e) => WalletModel.fromJson(e)).toList();
      num wallet = response.data['wallet'];

      emit(SuccessGetWalletState(allWallet, wallet));
    } on DioException catch (e) {
      emit(FailGetWalletState(e.response!.data));
    }
  }

  static XFile? image;

  changeImage(ChangeImageEvent event, Emitter<AccountState> emit) async {
    // ignore: invalid_use_of_visible_for_testing_member
    image = (await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery));
    emit(SuccessChangeImageState(image!.path));
  }

  getPolicy(GetPolicyEvent event, Emitter<AccountState> emit) async {
    emit(LoadingPolicyState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/policy',
          options: Options(headers: {'Accept-Language': 'ar'}));
      String data = response.data['data']['policy'];
      emit(SuccessPolicyState(data));
    } on DioException catch (e) {
      e.error;
      emit(FailPolicyState());
    }
  }

  static final amountController = TextEditingController();
  chargeWallet(ChargeWalletEvent event, Emitter<AccountState> emit) async {
    emit(LoadingChargeWalletState());
    try {
      var response = await Dio()
          .post('https://thimar.amr.aait-d.com/public/api/wallet/charge',
              data: {'transaction_id': '1111', 'amount': event.amount},
              options: Options(
                  headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
          .then((value) {
        add(GetWalletEvent());
      });

      emit(SuccessChargeWalletState(response.data['message']));
    } on DioException catch (e) {
      emit(FailChargetState(e.response!.data['message']));
    }
  }

  paymop(PaymopEventEvent event, Emitter<AccountState> emit) async {
    emit(LoadingPaymopState());
    try {
      final authToken = await PaymobService.getAuthToken();
      final orderId = await PaymobService.createOrder(
          authToken, int.parse(event.amount) * 100);
      final paymentKey = await PaymobService.getPaymentKey(
          authToken, orderId, int.parse(event.amount) * 100);
      String paymentUrl =
          "https://accept.paymob.com/api/acceptance/iframes/905872?payment_token=$paymentKey";
      // ignore: use_build_context_synchronously
      Navigator.push(event.context, MaterialPageRoute(builder: (c) {
        return PaymentWebView(
          paymentUrl: paymentUrl,
        );
      }));
      chargeWallet(ChargeWalletEvent(event.amount), emit);
      //

      emit(SuccessChargeWalletState('تمت عملية الدفع بنجاح'));
    } on DioException catch (e) {
      e.error;
    }
  }
}
