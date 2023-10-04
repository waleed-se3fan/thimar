part of 'bloc.dart';

class HomePageEvent {}

class BottomNavBarChangeEvent extends HomePageEvent {
  int index;
  BottomNavBarChangeEvent(this.index);
}

class GetSliderImagesEvent extends HomePageEvent {}

class GetSectionImagesEvent extends HomePageEvent {}

class GetAllCategoriesEvent extends HomePageEvent {}

class GetProductRateEvent extends HomePageEvent {
  int index;
  GetProductRateEvent(this.index);
}

class GetSectionDetailsEvent extends HomePageEvent {
  int index;
  GetSectionDetailsEvent(this.index);
}

class SearchEvent extends HomePageEvent {
  String input;
  SearchEvent(this.input);
}
