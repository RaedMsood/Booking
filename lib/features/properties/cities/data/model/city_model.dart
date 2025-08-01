class CityModel {
  final int id;
  final String name;
  final String description;
  final String image;

  CityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  static List<CityModel> fromJsonList(List json) {
    return json.map((e) => CityModel.fromJson(e)).toList();
  }

  factory CityModel.empty() {
    return CityModel(
      id: 0,
      name: '',
      description: '',
      image: '',
    );
  }
}
