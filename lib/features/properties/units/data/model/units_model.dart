import '../../../../../core/state/pagination_data/paginated_model.dart';

class SectionsOfPropertyModel {
  final int id;
  final String name;
  final List<UnitsModel>? units;

  SectionsOfPropertyModel({
    required this.id,
    required this.name,
    this.units,
  });

  factory SectionsOfPropertyModel.fromJson(Map<String, dynamic> json) {
    return SectionsOfPropertyModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      units: UnitsModel.fromJsonList(json['units'] ?? []),
    );
  }

  static List<SectionsOfPropertyModel> fromJsonList(List json) {
    return json.map((e) => SectionsOfPropertyModel.fromJson(e)).toList();
  }

  factory SectionsOfPropertyModel.empty() => SectionsOfPropertyModel(
        id: 0,
        name: '',
      );
}

class UnitsModel {
  final int id;
  final String name;
  final String price;
  final int maxGuests;
  final String? description;
  final String? image;

  UnitsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.maxGuests,
    this.description,
    this.image,
  });

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      price: json['price_per_night'] ?? '',
      maxGuests: json['max_guests'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
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
      );
}

class SectionsModel {
  final List<SectionsOfPropertyModel> sections;
  final PaginationModel<UnitsModel> units;

  SectionsModel({
    required this.sections,
    required this.units,
  });

  factory SectionsModel.fromJson(Map<String, dynamic> json) {
    return SectionsModel(
      sections: SectionsOfPropertyModel.fromJsonList(json['sections'] ?? []),
      units: PaginationModel<UnitsModel>.fromJson(
        json['unit'],
        (prop) {
          return UnitsModel.fromJson(prop);
        },
      ),
    );
  }

  static List<SectionsModel> fromJsonList(List json) {
    return json.map((e) => SectionsModel.fromJson(e)).toList();
  }

  SectionsModel copyWith({
    List<SectionsOfPropertyModel>? sections,
    PaginationModel<UnitsModel>? units,
  }) {
    return SectionsModel(
      sections: sections ?? this.sections,
      units: units ?? this.units,
    );
  }
  factory SectionsModel.empty() => SectionsModel(
        sections: [],
        units: PaginationModel.empty(),
      );
}
