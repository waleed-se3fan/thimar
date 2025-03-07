part of 'bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class LoadingGetCurrentOrderState extends OrderState {}

class SuccessGetCurrentOrderState extends OrderState {
  final List<OrderModel> orders;
  SuccessGetCurrentOrderState(this.orders);
}

class FailGetCurrentOrderState extends OrderState {}

class LoadingGetFinishedOrderState extends OrderState {}

class SuccessGetFinishedOrderState extends OrderState {
  final List<OrderModel> orders;
  SuccessGetFinishedOrderState(this.orders);
}

class FailGetFinishedOrderState extends OrderState {}

class LoadingCancelOrderState extends OrderState {}

class SuccessCancelOrderState extends OrderState {
  final String message;
  SuccessCancelOrderState(this.message);
}

class FailCancelOrderState extends OrderState {
  final String message;
  FailCancelOrderState(this.message);
}
