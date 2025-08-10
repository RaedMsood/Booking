class PropertyDataModel {
  final int id;
  final String name;
  final dynamic rating;
  final String type;
  final String city;
  final String district;
  final List<String> mainImageUrls;

  PropertyDataModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    required this.city,
    required this.district,
    required this.mainImageUrls,
  });

  factory PropertyDataModel.fromJson(Map<String, dynamic> json) {
    return PropertyDataModel(
      id: json['id'],
      name: json['name'] ?? '',
      rating: json['rating'] ?? 0.0,
      type: json['type'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      mainImageUrls: List<String>.from(json['main_image_url2'] ?? []),
    );
  }

  static List<PropertyDataModel> fromJsonList(List json) {
    return json.map((e) => PropertyDataModel.fromJson(e)).toList();
  }

  static PropertyDataModel empty() {
    return PropertyDataModel(
        id: 0,
        city: '',
        name: '',
        district: '',
        type: '',
        mainImageUrls: [],
        rating: 0);
  }
}
