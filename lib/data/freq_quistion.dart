class FrqQuistionModel {
  int id;
  String quistion;
  String answer;
  FrqQuistionModel(
    this.id,
    this.quistion,
    this.answer,
  );

  factory FrqQuistionModel.fromJson(Map<String, dynamic> json) {
    return FrqQuistionModel(
      json['id'] ?? '',
      json['question'] ?? '',
      json['answer'] ?? '',
    );
  }
}
