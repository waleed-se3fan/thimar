import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/data/carts.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';

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
  }
  static List<Data>? carts;
  static int? storeIndex;
  static int? cartIndex;
  static Carts? cartInfo;

  Future getAllCarts(GetAllCartsEvent event, Emitter<CartState> emit) async {
    emit(LoadingGetAllCartsState());
    try {
      var response = await Dio()
          .get('https://thimar.amr.aait-d.com/public/api/client/cart',
              options: Options(headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
              }));

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
    emit(LoadingStoretoCartState());
    /* equal index to check*/
    storeIndex = event.itemIndex;

    try {
      HomePageBloc().add(GetAllCategoriesEvent());
      await Dio().post('https://thimar.amr.aait-d.com/public/api/client/cart',
          options: Options(headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
          }),
          data: {'product_id': event.id, 'amount': '1'}).then((value) {
        emit(SuccessStoretoCartState(value.data['message']));
      });
      add(GetAllCartsEvent());
    } on DioException catch (e) {
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
              options: Options(headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
              }))
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

  selectDayAndDate(SelectDayAndDateEvent event, Emitter<CartState> emit) {
    if (event.date != null) {
      emit(SuccessSelectDayAndDateState(event.date));
    } else {
      emit(FailSelectDayAndDateState());
    }
  }

  selectTime(SelectTimeEvent event, Emitter<CartState> emit) {
    if (event.date != null) {
      emit(SuccessSelectTimeState(event.date));
    } else {
      emit(FailSelectTimeState());
    }
  }

  static String? note;
  noteFunction(NoteEvent event, Emitter<CartState> emit) {
    note = event.note;
  }
}
