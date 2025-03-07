import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salla_thumara/data/order.dart';
import 'package:salla_thumara/features/login/bloc.dart';

part 'events.dart';
part 'states.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<GetCurrentOrderEvent>(getCurrentOrder);
    on<GetFinishedOrderEvent>(getFinishedOrder);

    on<CancelOrderEvent>(cancelOrder);
  }
  static List<OrderModel>? orders;

  getCurrentOrder(GetCurrentOrderEvent event, Emitter<OrderState> emit) async {
    emit(LoadingGetCurrentOrderState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/client/orders/current',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print(response.data);
      List data = response.data['data'];
      orders = data.map((e) => OrderModel.fromJson(e)).toList();
      emit(SuccessGetCurrentOrderState(orders!));
    } on DioException catch (e) {
      e.error;
      emit(FailGetCurrentOrderState());
    }
  }

  getFinishedOrder(
      GetFinishedOrderEvent event, Emitter<OrderState> emit) async {
    emit(LoadingGetFinishedOrderState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/client/orders/finished',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print(response.data);
      List data = response.data['data'];
      orders = data.map((e) => OrderModel.fromJson(e)).toList();
      emit(SuccessGetFinishedOrderState(orders!));
    } on DioException catch (e) {
      e.error;
      emit(FailGetFinishedOrderState());
    }
  }

  getOrder(GetCurrentOrderEvent event, Emitter<OrderState> emit) async {
    emit(LoadingGetCurrentOrderState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/client/orders/current',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print(response.data);
      List data = response.data['data'];
      orders = data.map((e) => OrderModel.fromJson(e)).toList();
      emit(SuccessGetCurrentOrderState(orders!));
    } on DioException catch (e) {
      e.error;
      emit(FailGetCurrentOrderState());
    }
  }

  cancelOrder(CancelOrderEvent event, Emitter<OrderState> emit) async {
    emit(LoadingCancelOrderState());
    try {
      var response = await Dio().post(
          'https://thimar.amr.aait-d.com/public/api/client/orders/${event.id}/cancel',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

      emit(SuccessCancelOrderState(response.data['message']));
    } on DioException catch (e) {
      emit(FailCancelOrderState(e.response!.data['message']));
    }
  }
}
