import '../../../cities/data/model/city_model.dart';
import 'property_pagination_model.dart';

class PropertyModel {
  final List<CityModel> cities;
  final PropertyPaginationModel property;
  final List<BannersModel> banners;

  PropertyModel({
    required this.cities,
    required this.property,
    required this.banners,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      cities: CityModel.fromJsonList(json['cities'] ?? []),
      property: PropertyPaginationModel.fromJson(json['properties']),
      banners: BannersModel.fromJsonList(json['banners'] ?? []),
    );
  }

  PropertyModel copyWith({
    List<CityModel>? cities,
    PropertyPaginationModel? property,
    List<BannersModel>? banners,
  }) {
    return PropertyModel(
      cities: cities ?? this.cities,
      property: property ?? this.property,
      banners: banners ?? this.banners,
    );
  }

  factory PropertyModel.empty() {
    return PropertyModel(
      cities: [],
      property: PropertyPaginationModel.empty(),
      banners: [],
    );
  }
}
class BannersModel {
  final int id;
  final String image;
  final int idProp;
  final String type;

  BannersModel({
    required this.id,
    required this.image,
    required this.idProp,
    required this.type,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      image: json['image'] ?? '',
      idProp: json['bannerable_id'] ?? 0,
      type: json['bannerable_type'] ?? '',
    );
  }

  static List<BannersModel> fromJsonList(List json) {
    return json.map((e) => BannersModel.fromJson(e)).toList();
  }

  static BannersModel empty() {
    return BannersModel(
      id: 0,
      image: '',
      idProp: 0,
      type: '',
    );
  }
}