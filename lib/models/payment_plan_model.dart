class PaymentPlanModel {
  int? id;
  String? name;
  List? benefit;
  int? price;
  int? duration;
  String? frequency;

  PaymentPlanModel({
    this.id,
    this.name,
    this.benefit,
    this.price,
    this.duration,
    this.frequency,
  });

  factory PaymentPlanModel.fromJson(Map<String, dynamic> json) {
    return PaymentPlanModel(
      id: json['id'],
      name: json['name'],
      benefit: json['benefit'],
      price: json['price'],
      duration: json['duration'],
      frequency: json['frequency'],
    );
  }
}
