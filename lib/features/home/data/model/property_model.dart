class PropertyModel {
  final int id;
  final String name;
  final dynamic rating;
  final String type;
  final String city;
  final String district;
  final List<String> mainImageUrls;

  PropertyModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    required this.city,
    required this.district,
    required this.mainImageUrls,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      name: json['name'] ?? '',
      rating: json['rating'] ?? 0.0,
      type: json['type'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      mainImageUrls: List<String>.from(json['main_image_url'] ?? []),
    );
  }
}
