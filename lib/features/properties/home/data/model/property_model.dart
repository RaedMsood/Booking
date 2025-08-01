import '../../../cities/data/model/city_model.dart';
import 'property_pagination_model.dart';

class PropertyModel {
  final List<CityModel> cities;
  final PropertyPaginationModel property;

  PropertyModel({
    required this.cities,
    required this.property,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      cities: CityModel.fromJsonList(json['cities'] ?? []),

      property: PropertyPaginationModel.fromJson(json['properties']),
    );
  }

  PropertyModel copyWith({
    List<CityModel>? cities,
    PropertyPaginationModel? property,
  }) {
    return PropertyModel(
      cities: cities ?? this.cities,
      property: property ?? this.property,
    );
  }

  factory PropertyModel.empty() {
    return PropertyModel(
      cities: [],
      property: PropertyPaginationModel.empty(),
    );
  }
}
