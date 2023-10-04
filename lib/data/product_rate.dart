class ProductRate {
  num value;
  String comment;
  String client_name;
  String client_image;
  ProductRate(
    this.value,
    this.comment,
    this.client_name,
    this.client_image,
  );
  factory ProductRate.fromJson(Map<String, dynamic> json) {
    return ProductRate(
      json['value'] ?? '',
      json['comment'] ?? '',
      json['client_name'] ?? '',
      json['client_image'] ?? '',
    );
  }
}
