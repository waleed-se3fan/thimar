import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/data/carts.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';

part 'events.dart';
part 'states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<GetAllCartsEvent>(getAllCarts);
    on<StoreToCartEvent>(storeToCart);
    on<DeleteFromCart>(deleteFromCart);
    on<ChoosePaymentEvent>(choisePayment);
    on<SelectDayAndDateEvent>(selectDayAndDate);
    on<SelectTimeEvent>(selectTime);
    on<NoteEvent>(noteFunction);
    on<StoreOrderEvent>(storeEvent);
  }
  static List<Data>? carts;
  static int? storeIndex;
  static int? cartIndex;
  static Carts? cartInfo;
  Future getAllCarts(GetAllCartsEvent event, Emitter<CartState> emit) async {
    emit(LoadingGetAllCartsState());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/client/cart',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

      // List data = response.data['data'];
      // carts = data.map((e) => Data.fromJson(e)).toList();
      // emit(SuccessGetAllCartsState(carts!));
      // Map x = response.data;
      var respons = response.data;
      cartInfo = Carts.fromJson(respons);
      carts = cartInfo!.data;

      emit(SuccessGetAllCartsState(carts!, cartInfo!));

      return carts;
    } catch (e) {
      emit(FailGetAllCartsState());

      return [];
    }
  }

  Future storeToCart(StoreToCartEvent event, Emitter<CartState> emit) async {
    print('iiiiiiiiiiiiiiiiiiiiiiiiiii');
    //cartInfo!.data[event.itemIndex].amount++;
    emit(LoadingStoretoCartState());
    /* equal index to check*/
    storeIndex = event.itemIndex;

    try {
      HomePageBloc().add(GetAllCategoriesEvent());
      await Dio().post('https://thimar.amr.aait-d.com/public/api/client/cart',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}),
          data: {'product_id': event.id, 'amount': '1'}).then((value) {
        // add(GetAllCartsEvent());
        // add(GetCurrentOrderEvent() as CartEvent);
        print('sssssssssssssssssssssssssssss');
        emit(SuccessStoretoCartState(value.data['message']));
      });
      add(GetAllCartsEvent());
    } on DioException catch (e) {
      print('ffffffffffffffffffffffff');
      print(e.toString());
      emit(FailStoretoCartState());
    }
  }

  deleteFromCart(DeleteFromCart event, Emitter<CartState> emit) async {
    cartIndex = event.index;
    emit(LoadingDeleteCartState());
    try {
      await Dio()
          .delete(
              'https://thimar.amr.aait-d.com/public/api/client/cart/delete_item/${carts![event.index].id.toString()}',
              options: Options(
                  headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
          .then((value) => carts!.removeAt(event.index));
      add(GetAllCartsEvent());

      emit(SuccessDeleteCartState());
    } on DioException catch (e) {
      print(e.message);
      emit(FailDeleteCartState());
    }
  }

  choisePayment(ChoosePaymentEvent event, Emitter<CartState> emit) {
    emit(ChoosePaymentState(event.index));
  }

  static String? dayAndDate;
  selectDayAndDate(SelectDayAndDateEvent event, Emitter<CartState> emit) {
    // ignore: unnecessary_null_comparison
    if (event.date != null) {
      dayAndDate = event.date;
      emit(SuccessSelectDayAndDateState(event.date));
    } else {
      emit(FailSelectDayAndDateState());
    }
  }

  static String? time;

  selectTime(SelectTimeEvent event, Emitter<CartState> emit) {
    // ignore: unnecessary_null_comparison
    if (event.date != null) {
      time = event.date;
      emit(SuccessSelectTimeState(event.date));
    } else {
      emit(FailSelectTimeState());
    }
  }

  static String? note;
  noteFunction(NoteEvent event, Emitter<CartState> emit) {
    note = event.note;
  }

  storeEvent(StoreOrderEvent event, Emitter<CartState> emit) async {
    emit(LoadingStoreOrderState());
    print('iiiiiiiiiiiiiiiiiii');
    try {
      var response = await Dio().post(
          'https://thimar.amr.aait-d.com/public/api/client/orders',
          data: {
            'address_id': '1189',
            'date': dayAndDate,
            'time': time,
            'note': note,
            'pay_type': 'wallet',
            'transaction_id': '123',
            'coupon_code': 'blender2'
          },
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));
      print('sssssssssssssssssssss');
      print(response.data);
      carts!.clear();
      emit(SuccessStoreOrderState(response.data['message']));
    } on DioException catch (e) {
      print('ffffffffffffffffffffff');
      print(e.response?.data.toString());
      emit(FailStoreOrderState(e.response!.data['message']));
    }
  }
}
