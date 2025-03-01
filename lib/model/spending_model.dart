class SpendingModel {
  int? id;
  String name;
  num amount;
  String mode;
  String date;

  SpendingModel({
    this.id,
    required this.name,
    required this.amount,
    required this.mode,
    required this.date,
  });

  factory SpendingModel.formMap({required Map<String, dynamic> data}) {
    return SpendingModel(
      id: data['spending_id'],
      name: data['spending_name'],
      amount: data['spending_amount'],
      mode: data['spending_mode'],
      date: data['spending_date'],
    );
  }
}
