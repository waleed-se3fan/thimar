part of 'bloc.dart';

class CartEvent {}

class GetAllCartsEvent extends CartEvent {}

class StoreToCartEvent extends CartEvent {
  int id;
  int itemIndex;

  StoreToCartEvent(this.id, this.itemIndex);
}

class DeleteFromCart extends CartEvent {
  int index;
  DeleteFromCart(this.index);
}

class ChoosePaymentEvent extends CartEvent {
  int index;
  ChoosePaymentEvent(this.index);
}

class SelectDayAndDateEvent extends CartEvent {
  String date;
  SelectDayAndDateEvent(this.date);
}

class SelectTimeEvent extends CartEvent {
  String date;
  SelectTimeEvent(this.date);
}

class NoteEvent extends CartEvent {
  String note;
  NoteEvent(this.note);
}
