import 'address_model.dart';
import 'deposit_model.dart';
import 'features_model.dart';
import 'policy_model.dart';
import '../../../units/data/model/units_model.dart';

class PropertyDetailsModel {
  final int id;
  final List<String> images;
  final String name;
  final String description;
  final dynamic rating;
  final int reviewsCount;
  final List<FeaturesModel> features;
  final AddressModel address;
  final DepositModel deposit;
  final List<PolicyModel> policies;
  final List<UnitsModel> units;

  PropertyDetailsModel({
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.features,
    required this.address,
    required this.deposit,
    required this.policies,
    required this.units,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsModel(
      id: json['id'] as int,
      images: List<String>.from(json['images'] ?? []),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] as int,
      reviewsCount: json['reviews_count'] as int,
      features: FeaturesModel.fromJsonList(json['amenities'] ?? []),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      deposit: DepositModel.fromJson(json['deposit'] as Map<String, dynamic>),
      policies: PolicyModel.fromJsonList(json['policies'] ?? []),
      units: UnitsModel.fromJsonList(json['units'] ?? []),
    );
  }

  factory PropertyDetailsModel.empty() => PropertyDetailsModel(
        id: 0,
        name: '',
        description: '',
        rating: 0,
        reviewsCount: 0,
        deposit: DepositModel.empty(),
        address: AddressModel.empty(),
        features: <FeaturesModel>[],
        policies: <PolicyModel>[],
        units: <UnitsModel>[],
        images: <String>[],
      );
}
