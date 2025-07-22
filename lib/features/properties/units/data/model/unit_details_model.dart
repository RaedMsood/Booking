import '../../../property_details/data/models/deposit_model.dart';
import '../../../property_details/data/models/features_model.dart';
import 'attachments_model.dart';

class UnitDetailsModel {
  final int id;
  final String name;
  final String description;
  final int maxGuests;
  final int price;
  // final int deposit;
  final List<String> images;
  final List<FeaturesModel> features;
  final List<AttachmentsModel> attachments;
  final String checkInTime;
  final String checkOutTime;

  UnitDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.maxGuests,
    required this.price,
    // required this.deposit,
    required this.images,
    required this.features,
    required this.attachments,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory UnitDetailsModel.fromJson(Map<String, dynamic> json) {
    return UnitDetailsModel(
      id: json['id'] as int,
      name: json['name'] ??'',
      description: json['description'] ?? '',
      maxGuests: json['max_guests'] as int,
      price: json['price_per_night'] as int,
      // deposit: json['deposit'] as int,
      images: List<String>.from(json['images'] ??[]),
      features: FeaturesModel.fromJsonList(json['amenities'] ?? []),
      attachments: AttachmentsModel.fromJsonList(json['details'] ?? []),
      checkInTime: json['check_in_time'] ??'',
      checkOutTime: json['check_out_time'] ??'',
    );
  }
  factory UnitDetailsModel.empty() => UnitDetailsModel(
    id: 0,
    name: '',
    description: '',
    maxGuests: 0,
    price: 0,
    // deposit: DepositModel.empty(),
    images: <String>[],

    features: <FeaturesModel>[],
    attachments: <AttachmentsModel>[],
    checkInTime: '',
    checkOutTime: '',
  );

}