import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/features/home_page/bloc.dart';
import 'package:salla_thumara/features/login/bloc.dart';

import '../../data/catigories.dart';

part 'events.dart';
part 'states.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavouriteEvent>((event, emit) {});
    on<GetFavouriteEvent>(getAllFavourites);
    on<AddToFavourite>(addToFavourite);
    on<RemoveFromFavourite>(removeFromCart);
  }

  static List<Category>? favourites;
  Future getAllFavourites(
      GetFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(LoadingFavouritesState());
    try {
      await Dio()
          .get(
              'https://thimar.amr.aait-d.com/public/api/client/products/favorites',
              options: Options(
                  headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
          .then((value) {
        if (value.data['data'] == null) {
          emit(EmptyFavouriteState());
        } else {
          List data = value.data['data'];
          favourites = data.map((e) => Category.fromJson(e)).toList();
          print(favourites![0].images.toString());

          emit(SuccessFavouritesState(favourites!));
        }
      });
    } on DioException catch (e) {
      e.error;
      emit(FailFavouritesState());
    }
  }

  Future addToFavourite(
      AddToFavourite event, Emitter<FavouriteState> emit) async {
    emit(LoadingAddtoFavourite());
    try {
      var response = await Dio().post(
          'https://thimar.amr.aait-d.com/public/api/client/products/${HomePageBloc.list1![event.id].id.toString()}/add_to_favorite',
          options: Options(headers: {
            'Accept-Language': 'ar',
            'Authorization': 'Bearer ${LoginBloc.token}'
          }));
      print(response.data['message']);
      emit(SuccessAddtoFavourite(response.data['message']));
    } on DioException catch (e) {
      e.error;
      emit(FailAddtoFavourite());
    }
  }

  removeFromCart(
      RemoveFromFavourite event, Emitter<FavouriteState> emit) async {
    emit(LoadingRemoveFromFavourite());
    try {
      await Dio().post(
          'https://thimar.amr.aait-d.com/public/api/client/products/${HomePageBloc.list1![event.id].id.toString()}/remove_from_favorite',
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

      emit(SuccessRemoveFromFavourite('تم ازالة المنتج من قائمة المفضلة'));
    } on DioException catch (e) {
      e.error;
      emit(FailRemoveFromFavourite());
    }
  }
}
