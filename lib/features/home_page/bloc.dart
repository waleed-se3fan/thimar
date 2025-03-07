import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/core/utilities/api.dart';
import 'package:salla_thumara/data/catigories.dart';
import 'package:salla_thumara/data/product_rate.dart';
import 'package:salla_thumara/data/section.dart';
import 'package:salla_thumara/data/slider.dart';
import 'package:salla_thumara/features/login/bloc.dart';

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
    on<ChangeRangeSliderEvent>(rangeSlider);
    on<CheckBoxEvent>(checkFunction);
    on<FilterDataEvent>(filterData);
  }

  int index = 0;
  void changeIndex(BottomNavBarChangeEvent event, Emitter<HomePageState> emit) {
    index = event.index;
    emit(BottomNavBarChangeState());
  }
/* get Home Page Images */

  getHomePageImages(
      GetSliderImagesEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingImagesState());
    try {
      var response = await Dio().get('${ApiClass.baseApi}sliders');

      List data = response.data['data'];
      List<SliderModel> slider =
          data.map((e) => SliderModel.fromJson(e)).toList();

      emit(SuccesLoadingImages(slider));
    } on DioException {
      emit(FailLoadingImages('fail'));
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
          options:
              Options(headers: {'Authorization': 'Bearer ${LoginBloc.token}'}));

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
      e.error;
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
      if (response.data['data'] == null) {
        emit(FailProductRateState());
      } else {
        List data = response.data['data'];
        productRates = data.map((e) => ProductRate.fromJson(e)).toList();

        //print(productRates!.length.toString());
        emit(SuccessProductRateState(productRates!));
      }
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

//section functions
  static double min = 0;
  static double max = 50;
  rangeSlider(ChangeRangeSliderEvent event, Emitter<HomePageState> emit) {
    min = event.start;
    max = event.end;
    print('min$min');
    print('max$max');
    emit(ChangeRangeSliderState(min, max));
  }

  static bool check = false;
  static String checkString = 'asc';
  checkFunction(CheckBoxEvent event, Emitter<HomePageState> emit) {
    check = event.check;
    check ? checkString = 'asc' : checkString = 'desc';
    print(checkString);
    emit(CheckBoxState(check));
  }

  List<Category>? filterList;
  filterData(FilterDataEvent event, Emitter<HomePageState> emit) async {
    emit(LoadingFilterData());
    try {
      var response = await Dio().get(
          'https://thimar.amr.aait-d.com/public/api/products?filter=${checkString}&category_id=${event.index}&min_price=${min}&max_price=${max}');
      List data = response.data['data'];

      filterList = data.map((e) => Category.fromJson(e)).toList();

      emit(SuccessFilterData(filterList!));
      print(filterList.toString());
    } on DioException catch (e) {
      e.error;
      emit(FailFilterData());
    }
  }
}
