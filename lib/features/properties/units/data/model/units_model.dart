class UnitsModel {
  final int id;
  final String name;
  final String price;
  final int maxGuests;
  final String? description;
  final String? image;
  final num singleBed;
  final num doubleBed;

  UnitsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.maxGuests,
    this.description,
    this.image,
    required this.singleBed,
    required this.doubleBed,
  });

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      price: json['price_per_night'] ?? '',
      maxGuests: json['max_guests'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      singleBed: json['single_bed'] ?? 0,
      doubleBed: json['double_bed'] ?? 0,
    );
  }

  static List<UnitsModel> fromJsonList(List json) {
    return json.map((e) => UnitsModel.fromJson(e)).toList();
  }

  factory UnitsModel.empty() => UnitsModel(
        id: 0,
        name: '',
        price: '',
        maxGuests: 0,
        description: null,
        image: null,
        singleBed: 0,
        doubleBed: 0,
      );
}
