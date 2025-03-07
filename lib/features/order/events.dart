part of 'bloc.dart';

@immutable
sealed class OrderEvent {}

class GetCurrentOrderEvent extends OrderEvent {}

class GetFinishedOrderEvent extends OrderEvent {}

class CancelOrderEvent extends OrderEvent {
  final int id;
  CancelOrderEvent(this.id);
}
