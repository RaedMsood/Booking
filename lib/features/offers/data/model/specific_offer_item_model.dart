class SpecificOfferItemModel {
  const SpecificOfferItemModel({
    required this.id,
    required this.title,
    required this.imagePath,
  });

  final int id;
  final String title;
  final String imagePath;

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  factory SpecificOfferItemModel.fromJson(Map<String, dynamic> json) {
    return SpecificOfferItemModel(
      id: _parseInt(json['id']),
      title: json['name']?.toString() ?? json['title']?.toString() ?? '',
      imagePath: json['image']?.toString() ?? json['imagePath']?.toString() ?? '',
    );
  }

  static List<SpecificOfferItemModel> fromJsonList(List json) {
    return json
        .map((e) => SpecificOfferItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  factory SpecificOfferItemModel.empty() {
    return const SpecificOfferItemModel(
      id: 0,
      title: '',
      imagePath: '',
    );
  }
}

