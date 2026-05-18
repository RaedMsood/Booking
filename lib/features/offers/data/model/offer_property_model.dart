class OfferPropertyModel {
  final int id;
  final String name;
  final String image;

  const OfferPropertyModel({
    required this.id,
    required this.name,
    required this.image,
  });

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  factory OfferPropertyModel.fromJson(Map<String, dynamic> json) {
    return OfferPropertyModel(
      id: _parseInt(json['id']),
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  static List<OfferPropertyModel> fromJsonList(List json) {
    return json
        .map((e) => OfferPropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory OfferPropertyModel.empty() {
    return const OfferPropertyModel(
      id: 0,
      name: '',
      image: '',
    );
  }
}

