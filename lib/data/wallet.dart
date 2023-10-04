class WalletModel {
  num id;
  num amount;
  num before_charge;
  num after_charge;
  String date;
  String status_trans;
  String status;
  String transaction_type;
  String model_type;
  num model_id;
  String state;

  WalletModel(
      this.id,
      this.amount,
      this.before_charge,
      this.after_charge,
      this.date,
      this.status_trans,
      this.status,
      this.transaction_type,
      this.model_type,
      this.model_id,
      this.state);

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
        json['id'],
        json['amount'],
        json['before_charge'],
        json['after_charge'],
        json['date'],
        json['status_trans'],
        json['status'],
        json['transaction_type'],
        json['model_type'],
        json['model_id'],
        json['state']);
  }
}
