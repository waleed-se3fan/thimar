import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/core/utilities/api.dart';
import 'package:salla_thumara/data/catigories.dart';
import 'package:salla_thumara/data/product_rate.dart';
import 'package:salla_thumara/data/section.dart';
import 'package:salla_thumara/data/slider.dart';

part 'events.dart';
part 'states.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<GetSliderImagesEvent>(getHomePageImages);
    on<BottomNavBarChangeEvent>(changeIndex);
    on<GetSectionImagesEvent>(getSectionsImages);
    on<GetAllCategoriesEvent>(getAllCategories);
    on<GetProductRateEvent>(getProductRate);
    on<GetSectionDetailsEvent>(getSectionDetails);
    on<SearchEvent>(search);
  }

  int index = 0;
  void changeIndex(BottomNavBarChangeEvent event, Emitter<HomePageState> emit) {
    index = event.index;
    emit(BottomNavBarChangeState());
  }
/* get Home Page Images */

  Future<List> getHomePageImages(
      GetSliderImagesEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingImagesState());
    try {
      var response = await Dio().get('${ApiClass.baseApi}sliders');

      List data = response.data['data'];
      List<SliderModel> slider =
          data.map((e) => SliderModel.fromJson(e)).toList();

      emit(SuccesLoadingImages(slider));
      return slider;
    } on DioException {
      emit(FailLoadingImages('fail'));

      return [];
    }
  }

/*get section images*/

  static List<SectionModel> section = [];
  Future<List<SectionModel>> getSectionsImages(
      GetSectionImagesEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingImagesState());

    try {
      var response = await Dio().get('${ApiClass.baseApi}categories');
      List data = response.data['data'];

      section =
          data.map<SectionModel>((e) => SectionModel.fromJson(e)).toList();
      emit(SuccessSectionState(section));
      return section;
    } catch (e) {
      emit(FailSectionState());
      return [];
    }
  }

/* get all categories */

  static List<Category>? list1;
  Future<List<Category>> getAllCategories(
      GetAllCategoriesEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingGetAllCategories());
    try {
      var response1 = await Dio().get('${ApiClass.baseApi}products',
          options: Options(headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9wdWJsaWNcL2FwaVwvdmVyaWZ5IiwiaWF0IjoxNjkzMTIxMjQ1LCJleHAiOjE3MjQ2NTcyNDUsIm5iZiI6MTY5MzEyMTI0NSwianRpIjoiNUx5alVDR2d1M1d4dW9jVyIsInN1YiI6OTE4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7P9D3chjeVySRuj-Nuvmd16jj1hqZkZFMWxe2VDqDEg'
          }));

      List data1 = response1.data['data'];

      list1 = data1.map((e) => Category.fromJson(e)).toList();

      emit(SuccessGetAllCategories(list1!));

      return list1!;
    } on DioException catch (e) {
      print(e.toString());
      emit(FailGetAllCategories());
      return [];
    }
  }

/* get section details */

  Future<List<Category>> getSectionDetails(
      GetSectionDetailsEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingGetAllSectionDetailsState());
    try {
      var response =
          await Dio().get('${ApiClass.baseApi}categories/${event.index}');

      List data1 = response.data['data'];

      list1 = data1.map((e) => Category.fromJson(e)).toList();

      emit(SuccessGetAllSectionDetailsState(list1!));

      return list1!;
    } on DioException catch (e) {
      emit(FailGetAllSectionDetailsState());
      return [];
    }
  }
/*get product rate*/

  List<ProductRate>? productRates;
  getProductRate(GetProductRateEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingProductRateState());
    try {
      var response = await Dio().get(
          '${ApiClass.baseApi}products/${list1![event.index].id.toString()}/rates');

      List data = response.data['data'];

      productRates = data.map((e) => ProductRate.fromJson(e)).toList();
      //print(productRates!.length.toString());
      emit(SuccessProductRateState(productRates!));
    } on DioException catch (e) {
      emit(FailProductRateState());
      return e;
    }
  }

  /// handle search for items
  List<Category>? searchData;
  search(SearchEvent event, Emitter<HomePageState> emit) {
    if (event.input != '') {
      searchData = list1!
          .where((element) => element.title.contains(event.input))
          .toList();
      print(searchData.toString());
      emit(SuccessSearchState(searchData!));
    } else {
      emit(FailSearchState());
    }
  }
}
