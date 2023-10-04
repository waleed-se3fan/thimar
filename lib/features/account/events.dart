part of 'bloc.dart';

class AccountEvent {}

class EditPersonalDataEvent extends AccountEvent {
  // File image;
  String fullname;
  String phone;
  int cityId;
  EditPersonalDataEvent(this.fullname, this.phone, this.cityId);
}

class GetTermsEvent extends AccountEvent {}

class ComplaintsAndSuggestionEvent extends AccountEvent {
  String name;
  String phoneName;
  String content;
  ComplaintsAndSuggestionEvent(this.name, this.phoneName, this.content);
}

class GetFreqQuistionEvent extends AccountEvent {}

class CheckVisibilityEvent extends AccountEvent {
  bool state;
  CheckVisibilityEvent(this.state);
}

class GetAboutAppEvent extends AccountEvent {}

class GetWalletEvent extends AccountEvent {}

class ChargeWalletEvent extends AccountEvent {
  String amount;
  ChargeWalletEvent(this.amount);
}
