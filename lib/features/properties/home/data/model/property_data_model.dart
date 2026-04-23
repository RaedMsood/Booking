class PropertyDataModel {
  final int id;
  final String name;
  final dynamic rating;
  final String type;
  final String city;
  final String district;
  final List<String> mainImageUrls;
  final bool isFavorite;
  PropertyDataModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    required this.city,
    required this.district,
    required this.mainImageUrls,
    required this.isFavorite
  });

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static num _parseNum(dynamic value) {
    if (value is num) return value;
    return num.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return normalized == 'true' || normalized == '1';
  }

  static List<String> _parseImages(Map<String, dynamic> json) {
    final raw = json['main_image_url2'] ?? json['main_image_url'] ?? const [];
    if (raw is List) {
      return raw.map((e) => e.toString()).toList();
    }
    return const <String>[];
  }

  factory PropertyDataModel.fromJson(Map<String, dynamic> json) {
    return PropertyDataModel(
        id: _parseInt(json['id']),
        name: json['name'] ?? '',
        rating: _parseNum(json['totalRate'] ?? json['rating']),
        type: json['type'] ?? '',
        city: json['city'] ?? '',
        district: json['district'] ?? '',
        mainImageUrls: _parseImages(json),
        isFavorite: _parseBool(json['isFavorite'])
    );
  }

  PropertyDataModel copyWith({
    int? id,
    String? name,
    dynamic rating,
    String? type,
    String? city,
    String? district,
    List<String>? mainImageUrls,
    bool? isFavorite,
  }) {
    return PropertyDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      city: city ?? this.city,
      district: district ?? this.district,
      mainImageUrls: mainImageUrls ?? this.mainImageUrls,
      isFavorite: isFavorite ?? this.isFavorite,
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
        isFavorite: false,
        rating: 0);
  }
}