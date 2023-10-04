part of 'bloc.dart';

class AddressesEvent {}

class GetAllAdressessEvent extends AddressesEvent {}

class CheckGetAllAdressessEvent extends AddressesEvent {}

class DeleteAddressEvent extends AddressesEvent {
  int index;
  DeleteAddressEvent(this.index);
}
