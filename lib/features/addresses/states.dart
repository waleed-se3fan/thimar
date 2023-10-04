part of 'bloc.dart';

class AddressesState {}

final class AddressesInitial extends AddressesState {}

class SuccesGetAllAddressesState extends AddressesState {
  List<Addresses> allAdresses;
  SuccesGetAllAddressesState(this.allAdresses);
}

class FailGetAllAddressesState extends AddressesState {}

class LoadingGetAllAddressesState extends AddressesState {}

class LoadingDeleteAddress extends AddressesState {}

class SuccessDeleteAdress extends AddressesState {}

class FailDeleteAddress extends AddressesState {}

class EmptyAddressesState extends AddressesState {}
