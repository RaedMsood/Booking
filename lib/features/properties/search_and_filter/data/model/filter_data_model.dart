import '../../../property_details/data/models/features_model.dart';

class FilterDataModel {
  final List<FeaturesModel> features;
  final List<CityOrUnitTypesModel> unitTypes;
  final List<CityOrUnitTypesModel> cities;
  final String minPrice;
  final String maxPrice;

  FilterDataModel({
    required this.features,
    required this.unitTypes,
    required this.cities,
    required this.minPrice,
    required this.maxPrice,
  });

  factory FilterDataModel.fromJson(Map<String, dynamic> json) {
    return FilterDataModel(
      features: FeaturesModel.fromJsonList(json['amenities'] ?? []),
      unitTypes: CityOrUnitTypesModel.fromJsonList(json['unit_types'] ?? []),
      cities: CityOrUnitTypesModel.fromJsonList(json['cities'] ?? []),
      minPrice: json['min_price'] ?? '',
      maxPrice: json['max_price'] ?? '',
    );
  }

  factory FilterDataModel.empty() {
    return FilterDataModel(
      features: [],
      unitTypes: [],
      cities: [],
      minPrice: '',
      maxPrice: '',
    );
  }
}

class CityOrUnitTypesModel{
  final int id;
  final String name;

  CityOrUnitTypesModel({required this.id, required this.name});

  factory CityOrUnitTypesModel.fromJson(Map<String, dynamic> json) {
    return CityOrUnitTypesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  static List<CityOrUnitTypesModel> fromJsonList(List json) {
    return json.map((e) => CityOrUnitTypesModel.fromJson(e)).toList();
  }

  factory CityOrUnitTypesModel.empty() => CityOrUnitTypesModel(
    id: 0,
    name: '',
  );
}