part of 'bloc.dart';

class CartState {}

class CartInitial extends CartState {}

class LoadingGetAllCartsState extends CartState {}

class SuccessGetAllCartsState extends CartState {
  List<Data> carts;
  Carts cartInfo;
  SuccessGetAllCartsState(this.carts, this.cartInfo);
}

class FailGetAllCartsState extends CartState {}

class LoadingStoretoCartState extends CartState {}

class SuccessStoretoCartState extends CartState {
  String message;
  SuccessStoretoCartState(this.message);
}

class FailStoretoCartState extends CartState {}

class LoadingDeleteCartState extends CartState {}

class SuccessDeleteCartState extends CartState {}

class FailDeleteCartState extends CartState {}

class ChoosePaymentState extends CartState {
  int index;
  ChoosePaymentState(this.index);
}

class SuccessSelectDayAndDateState extends CartState {
  String date;
  SuccessSelectDayAndDateState(this.date);
}

class FailSelectDayAndDateState extends CartState {}

class SuccessSelectTimeState extends CartState {
  String date;
  SuccessSelectTimeState(this.date);
}

class FailSelectTimeState extends CartState {}

class LoadingStoreOrderState extends CartState {}

class SuccessStoreOrderState extends CartState {
  String data;
  SuccessStoreOrderState(this.data);
}

class FailStoreOrderState extends CartState {
  String data;
  FailStoreOrderState(this.data);
}
