class AttachmentsModel {
  final String type;
  final int quantity;
  final String? description;
  final int status;
  final String icon;

  AttachmentsModel({
    required this.type,
    required this.quantity,
    this.description,
    required this.status,
    required this.icon,
  });

  factory AttachmentsModel.fromJson(Map<String, dynamic> json) {
    return AttachmentsModel(
      type: json['type'] ?? '',
      quantity: json['quantity'] as int,
      description: json['description'] ?? '',
      status: json['status'] as int,
      icon: json['icon'] ?? '',
    );
  }

  static List<AttachmentsModel> fromJsonList(List json) {
    return json.map((e) => AttachmentsModel.fromJson(e)).toList();
  }
}
