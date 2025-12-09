import '../../../property_details/data/models/features_model.dart';
import 'attachments_model.dart';

class UnitDetailsModel {
  final int id;
  final String name;
  final String description;
  final int maxGuests;
  final int price;
  final num deposit;
  final List<String> images;
  final List<FeaturesModel> features;
  final List<AttachmentsModel> attachments;
  final String checkInTime;
  final String checkOutTime;
  final num singleBed;
  final num doubleBed;
  final String? length;
  final String? width;
  final PropertyAtUnitDetailsModel property;

  UnitDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.maxGuests,
    required this.price,
    required this.deposit,
    required this.images,
    required this.features,
    required this.attachments,
    required this.checkInTime,
    required this.checkOutTime,
    required this.singleBed,
    required this.doubleBed,
     this.length,
     this.width,
    required this.property,
  });

  factory UnitDetailsModel.fromJson(Map<String, dynamic> json) {
    return UnitDetailsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      maxGuests: json['max_guests'] as int,
      price: json['price_per_night'] as int,
      deposit: json['deposit'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      features: FeaturesModel.fromJsonList(json['amenities'] ?? []),
      attachments: AttachmentsModel.fromJsonList(json['details'] ?? []),
      checkInTime: json['check_in_time'] ?? '',
      checkOutTime: json['check_out_time'] ?? '',
      singleBed: json['single_bed'] ?? 0,
      doubleBed: json['double_bed'] ?? 0,
      length: json['length']?.toString(),
      width: json['width']?.toString(),
      property: PropertyAtUnitDetailsModel.fromJson(
          json['property'] as Map<String, dynamic>),
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
        deposit: 0,
        features: <FeaturesModel>[],
        attachments: <AttachmentsModel>[],
        checkInTime: '',
        checkOutTime: '',
        singleBed: 0,
        doubleBed: 0,
        length: '',
        width: '',
        property: PropertyAtUnitDetailsModel.empty(),
      );
}

class PropertyAtUnitDetailsModel {
  final int id;
  final String name;
  final String location;
  final List<String> images;

  PropertyAtUnitDetailsModel({
    required this.id,
    required this.name,
    required this.location,
    required this.images,
  });

  factory PropertyAtUnitDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertyAtUnitDetailsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  factory PropertyAtUnitDetailsModel.empty() => PropertyAtUnitDetailsModel(
        id: 0,
        name: '',
        location: '',
        images: <String>[],
      );
}
