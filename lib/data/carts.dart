class Carts {
  final List<Data> data;
  final num total_price_before_discount;
  final num total_discount;
  final num total_price_with_vat;
  final num delivery_cost;
  final num free_delivery_price;
  final num vat;
  final num is_vip;
  final num vip_discount_percentage;
  final num min_vip_price;
  final String vip_message;
  final String status;

  Carts(
    this.data,
    this.total_price_before_discount,
    this.total_discount,
    this.total_price_with_vat,
    this.delivery_cost,
    this.free_delivery_price,
    this.vat,
    this.is_vip,
    this.vip_discount_percentage,
    this.min_vip_price,
    this.vip_message,
    this.status,
  );

  factory Carts.fromJson(Map<String, dynamic> json) {
    return Carts(
      List.from(json['data']).map((e) => Data.fromJson(e)).toList(),
      json['total_price_before_discount'] ?? '',
      json['total_discount'] ?? '',
      json['total_price_with_vat'] ?? '',
      json['delivery_cost'] ?? '',
      json['free_delivery_price'] ?? '',
      json['vat'] ?? '',
      json['is_vip'] ?? '',
      json['vip_discount_percentage'] ?? '',
      json['min_vip_price'] ?? '',
      json['vip_message'] ?? '',
      json['status'] ?? '',
    );
  }
}

class Data {
  final int id;
  final String title;
  final String image;
  final int amount;
  final num price_before_discount;
  final num discount;
  final num price;
  final num remaining_amount;

  Data(
    this.id,
    this.title,
    this.image,
    this.amount,
    this.price_before_discount,
    this.discount,
    this.price,
    this.remaining_amount,
  );

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      json['id'] ?? '',
      json['title'] ?? '',
      json['image'] ?? '',
      json['amount'] ?? '',
      json['price_before_discount'] ?? '',
      json['discount'] ?? '',
      json['price'] ?? '',
      json['remaining_amount'] ?? '',
    );
  }
}
