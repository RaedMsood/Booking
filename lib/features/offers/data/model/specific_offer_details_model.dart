import 'offer_property_model.dart';
import 'specific_offer_model.dart';

class SpecificOfferDetailsModel {
  final int id;
  final String title;
  final String? description;
  final String offerType;
  final String discountValue;
  final String startsAt;
  final String endsAt;
  final String bannerImage;
  final String bannerUrl;
  final List<OfferPropertyModel> properties;
  final int selectedPropertyId;
  final List<SpecificOfferModel> units;

  const SpecificOfferDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.offerType,
    required this.discountValue,
    required this.startsAt,
    required this.endsAt,
    required this.bannerImage,
    required this.bannerUrl,
    required this.properties,
    required this.selectedPropertyId,
    required this.units,
  });

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String get effectiveBannerImage =>
      bannerUrl.trim().isNotEmpty ? bannerUrl : bannerImage;

  factory SpecificOfferDetailsModel.fromJson(Map<String, dynamic> json) {
    final properties = OfferPropertyModel.fromJsonList(json['properties'] ?? []);
    final selectedPropertyId = _parseInt(json['selected_property_id']);

    return SpecificOfferDetailsModel(
      id: _parseInt(json['id']),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      offerType: json['offer_type']?.toString() ?? '',
      discountValue: json['discount_value']?.toString() ?? '',
      startsAt: json['starts_at']?.toString() ?? '',
      endsAt: json['ends_at']?.toString() ?? '',
      bannerImage: json['banner_image']?.toString() ?? '',
      bannerUrl: json['banner_url']?.toString() ?? '',
      properties: properties,
      selectedPropertyId: selectedPropertyId != 0
          ? selectedPropertyId
          : (properties.isNotEmpty ? properties.first.id : 0),
      units: SpecificOfferModel.fromJsonList(json['units'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'offer_type': offerType,
      'discount_value': discountValue,
      'starts_at': startsAt,
      'ends_at': endsAt,
      'banner_image': bannerImage,
      'banner_url': bannerUrl,
      'properties': properties.map((e) => e.toJson()).toList(),
      'selected_property_id': selectedPropertyId,
      'units': units.map((e) => e.toJson()).toList(),
    };
  }

  factory SpecificOfferDetailsModel.empty() {
    return const SpecificOfferDetailsModel(
      id: 0,
      title: '',
      description: null,
      offerType: '',
      discountValue: '',
      startsAt: '',
      endsAt: '',
      bannerImage: '',
      bannerUrl: '',
      properties: [],
      selectedPropertyId: 0,
      units: [],
    );
  }
}

