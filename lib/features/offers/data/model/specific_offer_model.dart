import '../../../../core/state/pagination_data/paginated_model.dart';
import 'offer_pricing_model.dart';

class SpecificOfferModel {
  final int id;
  final String name;
  final int propertyId;
  final String propertyName;
  final String unitType;
  final int singleBed;
  final int doubleBed;
  final String length;
  final String width;
  final int maxGuests;
  final String image;
  final bool isBestOffer;
  final int offerId;
  final String offerTitle;
  final String offerDescription;
  final String offerType;
  final int minimumNights;
  final num pricePerNight;
  final num basePricePerNight;
  final num priceBeforeOffer;
  final num priceAfterOffer;
  final num offerDiscountAmount;
  final OfferPricingModel? offerPricing;

  const SpecificOfferModel({
    required this.id,
    required this.name,
    required this.propertyId,
    required this.propertyName,
    required this.unitType,
    required this.singleBed,
    required this.doubleBed,
    required this.length,
    required this.width,
    required this.maxGuests,
    required this.image,
    required this.isBestOffer,
    required this.offerId,
    required this.offerTitle,
    required this.offerDescription,
    required this.offerType,
    required this.minimumNights,
    required this.pricePerNight,
    required this.basePricePerNight,
    required this.priceBeforeOffer,
    required this.priceAfterOffer,
    required this.offerDiscountAmount,
    required this.offerPricing,
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

  bool get hasActiveOffer =>
      offerPricing?.hasActiveOffer == true || isBestOffer || offerId != 0;

  num get effectivePrice {
    if ((offerPricing?.pricePerNight ?? 0) > 0) {
      return offerPricing!.pricePerNight;
    }
    if (priceAfterOffer > 0) return priceAfterOffer;
    return pricePerNight;
  }

  num? get originalPriceBeforeDiscount {
    final basePrice = offerPricing?.basePricePerNight ?? priceBeforeOffer;
    if (!hasActiveOffer || basePrice <= 0) {
      return null;
    }
    return basePrice;
  }

  factory SpecificOfferModel.fromJson(Map<String, dynamic> json) {
    return SpecificOfferModel(
      id: _parseInt(json['id']),
      name: json['name']?.toString() ?? '',
      propertyId: _parseInt(json['property_id']),
      propertyName: json['property_name']?.toString() ?? '',
      unitType: json['unit_type']?.toString() ?? '',
      singleBed: _parseInt(json['single_bed']),
      doubleBed: _parseInt(json['double_bed']),
      length: json['length']?.toString() ?? '',
      width: json['width']?.toString() ?? '',
      maxGuests: _parseInt(json['max_guests']),
      image: json['image']?.toString() ?? '',
      isBestOffer: _parseBool(json['is_best_offer']),
      offerId: _parseInt(json['offer_id']),
      offerTitle: json['offer_title']?.toString() ?? '',
      offerDescription: json['offer_description']?.toString() ?? '',
      offerType: json['offer_type']?.toString() ?? '',
      minimumNights: _parseInt(json['minimum_nights']),
      pricePerNight: _parseNum(json['price_per_night']),
      basePricePerNight: _parseNum(json['base_price_per_night']),
      priceBeforeOffer: _parseNum(json['price_before_offer']),
      priceAfterOffer: _parseNum(json['price_after_offer']),
      offerDiscountAmount: _parseNum(json['offer_discount_amount']),
      offerPricing: json['offer_pricing'] is Map<String, dynamic>
          ? OfferPricingModel.fromJson(
              json['offer_pricing'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'property_id': propertyId,
      'property_name': propertyName,
      'unit_type': unitType,
      'single_bed': singleBed,
      'double_bed': doubleBed,
      'length': length,
      'width': width,
      'max_guests': maxGuests,
      'image': image,
      'is_best_offer': isBestOffer,
      'offer_id': offerId,
      'offer_title': offerTitle,
      'offer_description': offerDescription,
      'offer_type': offerType,
      'minimum_nights': minimumNights,
      'price_per_night': pricePerNight,
      'base_price_per_night': basePricePerNight,
      'price_before_offer': priceBeforeOffer,
      'price_after_offer': priceAfterOffer,
      'offer_discount_amount': offerDiscountAmount,
      'offer_pricing': offerPricing?.toJson(),
    };
  }

  static List<SpecificOfferModel> fromJsonList(List json) {
    return json
        .map((e) => SpecificOfferModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static PaginationModel<SpecificOfferModel> paginationFromJson(
    Map<String, dynamic> json,
  ) {
    final paginationJson = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    return PaginationModel<SpecificOfferModel>.fromJson(
      paginationJson,
      (item) => SpecificOfferModel.fromJson(item as Map<String, dynamic>),
    );
  }

  factory SpecificOfferModel.empty() {
    return const SpecificOfferModel(
      id: 0,
      name: '',
      propertyId: 0,
      propertyName: '',
      unitType: '',
      singleBed: 0,
      doubleBed: 0,
      length: '',
      width: '',
      maxGuests: 0,
      image: '',
      isBestOffer: false,
      offerId: 0,
      offerTitle: '',
      offerDescription: '',
      offerType: '',
      minimumNights: 0,
      pricePerNight: 0,
      basePricePerNight: 0,
      priceBeforeOffer: 0,
      priceAfterOffer: 0,
      offerDiscountAmount: 0,
      offerPricing: null,
    );
  }
}

