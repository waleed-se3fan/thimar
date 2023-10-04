part of 'bloc.dart';

class AccountState {}

final class AccountInitial extends AccountState {}

class LoadingGetTermsState extends AccountState {}

class SuccessGetTermsState extends AccountState {
  String data;
  SuccessGetTermsState(this.data);
}

class FailGetTermsState extends AccountState {}

class LoadingComplaintsAndSuggestionState extends AccountState {}

class SuccessComplaintsAndSuggestionState extends AccountState {
  String message;
  SuccessComplaintsAndSuggestionState(this.message);
}

class FailComplaintsAndSuggestionState extends AccountState {
  String message;
  FailComplaintsAndSuggestionState(this.message);
}

class LoadingGetFreqQuistionState extends AccountState {}

class SuccessGetFreqQuistionState extends AccountState {
  List<FrqQuistionModel> freqQuisList;
  SuccessGetFreqQuistionState(this.freqQuisList);
}

class FailGetFreqQuistionState extends AccountState {}

class CheckVisibleState extends AccountState {
  bool state;
  CheckVisibleState(this.state);
}

class LoadingGetAboutAppState extends AccountState {}

class SuccessGetAboutAppState extends AccountState {
  String message;
  SuccessGetAboutAppState(this.message);
}

class FailGetAboutAppState extends AccountState {}

class LoadingGetWalletState extends AccountState {}

class SuccessGetWalletState extends AccountState {
  List<WalletModel> allWallet;
  num wallet;
  SuccessGetWalletState(this.allWallet, this.wallet);
}

class FailGetWalletState extends AccountState {
  String message;
  FailGetWalletState(this.message);
}

class LoadingChargeWalletState extends AccountState {}

class SuccessChargeWalletState extends AccountState {
  String messgae;
  SuccessChargeWalletState(this.messgae);
}

class FailChargetState extends AccountState {
  String message;
  FailChargetState(this.message);
}
