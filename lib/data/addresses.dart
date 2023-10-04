class Addresses {
  final int id;
  final String type;
  final double lat;
  final double lng;
  final String description;
  final bool isDefault;
  final String phone;
  final String location;
  Addresses(
    this.id,
    this.type,
    this.lat,
    this.lng,
    this.description,
    this.isDefault,
    this.phone,
    this.location,
  );

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      json['id'] ?? 'nullData',
      json['type'] ?? 'nullData',
      json['lat'] ?? 'nullData',
      json['lng'] ?? 'nullData',
      json['description'] ?? 'nullData',
      json['is_default'] ?? 'nullData',
      json['phone'] ?? 'nullData',
      json['location'] ?? 'nullData',
    );
  }
}
