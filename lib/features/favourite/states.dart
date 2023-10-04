part of 'bloc.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class LoadingFavouritesState extends FavouriteState {}

class SuccessFavouritesState extends FavouriteState {
  final List<Category> favourites;
  SuccessFavouritesState(this.favourites);
}

class FailFavouritesState extends FavouriteState {}

class LoadingAddtoFavourite extends FavouriteState {}

class SuccessAddtoFavourite extends FavouriteState {
  final String message;
  SuccessAddtoFavourite(this.message);
}

class FailAddtoFavourite extends FavouriteState {}

class EmptyFavouriteState extends FavouriteState {}

class NotInternetState extends FavouriteState {}

class LoadingRemoveFromFavourite extends FavouriteState {}

class SuccessRemoveFromFavourite extends FavouriteState {
  final String message;
  SuccessRemoveFromFavourite(this.message);
}

class FailRemoveFromFavourite extends FavouriteState {}
