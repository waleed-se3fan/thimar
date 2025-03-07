import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:salla_thumara/data/addresses.dart';
import 'package:salla_thumara/features/login/bloc.dart';

part 'events.dart';
part 'states.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial()) {
    on<AddressesEvent>((event, emit) {});
    on<GetAllAdressessEvent>(getAllAddresses);
    on<DeleteAddressEvent>(deleteAddress);
  }
  static List<Addresses>? myAddresses;

  static int? index;

  Future<List<Addresses>?> getAllAddresses(
      GetAllAdressessEvent event, Emitter<AddressesState> emit) async {
    emit(LoadingGetAllAddressesState());

    try {
      await Dio()
          .get('https://thimar.amr.aait-d.com/public/api/client/addresses',
              options: Options(
                  headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
          .then((value) {
        if (value.data['data'] == null) {
          emit(EmptyAddressesState());
        } else {
          List data = value.data['data'];
          myAddresses = data.map((e) => Addresses.fromJson(e)).toList();
          emit(SuccesGetAllAddressesState(myAddresses!));
        }
      });
    } on DioException catch (e) {
      print(e.toString());
      emit(FailGetAllAddressesState());
      return [];
    }
    return null;
  }

  void delete(int id) {
    Dio()
        .delete('https://thimar.amr.aait-d.com/public/api/client/addresses/$id',
            options: Options(
                headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
        .then((value) {
      myAddresses?.removeAt(id);
    });
  }

  deleteAddress(DeleteAddressEvent event, Emitter<AddressesState> emit) async {
    emit(LoadingDeleteAddress());

    /* equal index to check*/
    index = myAddresses!
        .indexWhere((element) => element.id == myAddresses![event.index].id);
    try {
      await Dio()
          .delete(
              'https://thimar.amr.aait-d.com/public/api/client/addresses/${myAddresses![event.index].id}',
              options: Options(
                  headers: {'Authorization': 'Bearer ${LoginBloc.token}'}))
          .then((value) {
        myAddresses?.removeAt(event.index);
      });
      emit(SuccessDeleteAdress());
    } on DioException catch (e) {
      print(e.toString());
      emit(FailDeleteAddress());
    }
  }
}
