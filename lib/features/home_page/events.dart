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

class ChangeRangeSliderEvent extends HomePageEvent {
  double start;
  double end;
  ChangeRangeSliderEvent(this.start, this.end);
}

class CheckBoxEvent extends HomePageEvent {
  bool check;
  CheckBoxEvent(this.check);
}

class FilterDataEvent extends HomePageEvent {
  int index;
  FilterDataEvent(this.index);
}
