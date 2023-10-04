part of 'bloc.dart';

sealed class FavouriteEvent {}

class GetFavouriteEvent extends FavouriteEvent {}

class AddToFavourite extends FavouriteEvent {
  final int id;
  AddToFavourite(this.id);
}

class RemoveFromFavourite extends FavouriteEvent {
  final int id;
  RemoveFromFavourite(this.id);
}
