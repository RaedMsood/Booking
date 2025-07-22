class FeaturesModel {
  final String name;
  final String icon;

  FeaturesModel({required this.name, required this.icon});

  factory FeaturesModel.fromJson(Map<String, dynamic> json) {
    return FeaturesModel(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  static List<FeaturesModel> fromJsonList(List json) {
    return json.map((e) => FeaturesModel.fromJson(e)).toList();
  }

  factory FeaturesModel.empty() => FeaturesModel(
        name: '',
        icon: '',
      );
}
