class FeaturesModel {
  final int id;
  final String name;
  final String icon;

  FeaturesModel({required this.id, required this.name, required this.icon});

  factory FeaturesModel.fromJson(Map<String, dynamic> json) {
    return FeaturesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  static List<FeaturesModel> fromJsonList(List json) {
    return json.map((e) => FeaturesModel.fromJson(e)).toList();
  }

  factory FeaturesModel.empty() => FeaturesModel(
        id: 0,
        name: '',
        icon: '',
      );
}
