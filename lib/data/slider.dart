class SliderModel {
  int id;
  String image;
  SliderModel(
    this.id,
    this.image,
  );
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      json['id'],
      json['media'],
    );
  }
}
