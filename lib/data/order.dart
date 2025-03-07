class OrderModel {
  num id;
  String status;
  String datee;
  String time;
  num order_price;
  num delivery_price;
  num total_price;
  String client_name;
  String phone;
  String location;
  String delivery_payer;
  List<ProductsModel> products;
  String pay_type;
  String note;
  num is_vip;
  num vip_discount_percentage;
  OrderModel(
      this.id,
      this.status,
      this.datee,
      this.time,
      this.order_price,
      this.delivery_price,
      this.total_price,
      this.client_name,
      this.phone,
      this.location,
      this.delivery_payer,
      this.products,
      this.pay_type,
      this.note,
      this.is_vip,
      this.vip_discount_percentage);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      json['id'] ?? '',
      json['status'] ?? '',
      json['date'] ?? '',
      json['time'] ?? '',
      json['order_price'] ?? '',
      json['delivery_price'] ?? '',
      json['total_price'] ?? '',
      json['client_name'] ?? '',
      json['phone'] ?? '',
      json['location'] ?? '',
      json['delivery_payer'] ?? '',
      List.from(json['products'])
          .map((e) => ProductsModel.fromJson(e))
          .toList(),
      json['pay_type'] ?? '',
      json['note'] ?? '',
      json['is_vip'] ?? '',
      json['vip_discount_percentage'] ?? '',
    );
  }
}

class ProductsModel {
  String name;
  String url;
  ProductsModel(
    this.name,
    this.url,
  );
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      json['name'] ?? '',
      json['url'] ?? '',
    );
  }
}
