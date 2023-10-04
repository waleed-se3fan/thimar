part of 'bloc.dart';

class HomePageState {}

final class HomePageInitial extends HomePageState {}

class BottomNavBarChangeState extends HomePageState {}

class LoadingImagesState extends HomePageState {}

class SuccesLoadingImages extends HomePageState {
  List<SliderModel>? images;
  SuccesLoadingImages(this.images);
}

class FailLoadingImages extends HomePageState {
  String? message;
  FailLoadingImages(this.message);
}

class LoadingSectionImages extends HomePageState {}

class SuccessSectionState extends HomePageState {
  List<SectionModel> image;
  SuccessSectionState(this.image);
}

class FailSectionState extends HomePageState {}

class LoadingGetAllCategories extends HomePageState {}

class FailGetAllCategories extends HomePageState {}

class SuccessGetAllCategories extends HomePageState {
  List<Category> allCategories;
  SuccessGetAllCategories(this.allCategories);
}

class LoadingProductRateState extends HomePageState {}

class SuccessProductRateState extends HomePageState {
  List<ProductRate> productRates;
  SuccessProductRateState(this.productRates);
}

class FailProductRateState extends HomePageState {}

class LoadingGetAllSectionDetailsState extends HomePageState {}

class FailGetAllSectionDetailsState extends HomePageState {}

class SuccessGetAllSectionDetailsState extends HomePageState {
  List<Category> allCategories;
  SuccessGetAllSectionDetailsState(this.allCategories);
}

class SuccessSearchState extends HomePageState {
  List<Category> searchCategory;
  SuccessSearchState(this.searchCategory);
}

class FailSearchState extends HomePageState {}
