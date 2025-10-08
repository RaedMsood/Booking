class PaymentMethodsModel {
  final int id;
  final String name;
  final String title;
  final int type;
  final String? image;

  PaymentMethodsModel({
    required this.id,
    required this.name,
    required this.title,
    required this.type,
    required this.image,
    // this.image,
  });

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      type: (json['type'] as num).toInt(),
      image: json['image'] ?? '',
    );
  }
  static List<PaymentMethodsModel> fromJsonList(List json) {
    return json.map((e) => PaymentMethodsModel.fromJson(e)).toList();
  }


  static PaymentMethodsModel empty() {
    return PaymentMethodsModel(
      id: 0,
      name: '',
      title: '',
      type: 0,
      image: '',
    );
  }
}
