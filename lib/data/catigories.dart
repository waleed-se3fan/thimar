class Category {
  final num id;
  final num category_id;
  final String title;
  final String description;
  final num price_before_discount;
  final num price;
  final num amount;
  final num is_active;
  bool is_favorite;
  final num discount;
  final Unit unit;
  final List<Images> images;
  final String main_image;
  Category(
      this.id,
      this.category_id,
      this.title,
      this.description,
      this.price_before_discount,
      this.price,
      this.amount,
      this.is_active,
      this.discount,
      this.is_favorite,
      this.unit,
      this.images,
      this.main_image);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        json['id'] ?? '',
        json['category_id'] ?? '',
        json['title'] ?? '',
        json['description'] ?? '',
        json['price_before_discount'] ?? '',
        json['price'] ?? '',
        json['amount'] ?? '',
        json['is_active'] ?? '',
        json['discount'] ?? '',
        json['is_favorite'] ?? '',
        Unit.fromJson(json['unit']),
        List.from(json['images']).map((e) => Images.fromJson(e)).toList(),
        json['main_image'] ?? '');
  }
}

class Unit {
  int id;
  String name;
  String type;
  Unit(
    this.id,
    this.name,
    this.type,
  );
  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      json['id'] ?? '',
      json['name'] ?? '',
      json['type'] ?? '',
    );
  }
}

class Images {
  String name;
  String url;
  Images(
    this.name,
    this.url,
  );
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      json['name'] ?? '',
      json['url'] ?? '',
    );
  }
}
