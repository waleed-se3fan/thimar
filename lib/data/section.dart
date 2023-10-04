class SectionModel {
  final int id;
  final String name;
  final String image;
  SectionModel(
    this.id,
    this.name,
    this.image,
  );
  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      json['id'] ?? 'nullData',
      json['name'] ?? 'nullData',
      json['media'] ?? 'nullData',
    );
  }
}
