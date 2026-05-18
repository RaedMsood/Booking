import 'offer_details_model.dart';

class OfferPricingModel {
  final bool hasActiveOffer;
  final int minimumNights;
  final String startsAt;
  final String endsAt;
  final num totalBeforeOffer;
  final num totalAfterOffer;
  final num totalDiscountAmount;
  final num basePricePerNight;
  final num pricePerNight;
  final num discountAmountPerNight;
  final OfferDetailsModel? offer;


  const OfferPricingModel({
    required this.hasActiveOffer,
    required this.minimumNights,
    required this.startsAt,
    required this.endsAt,
    required this.totalBeforeOffer,
    required this.totalAfterOffer,
    required this.totalDiscountAmount,
    required this.basePricePerNight,
    required this.pricePerNight,
    required this.discountAmountPerNight,
    required this.offer,
  });

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

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  factory OfferPricingModel.fromJson(Map<String, dynamic> json) {
    final offerJson = json['offer'] is Map<String, dynamic>
        ? json['offer'] as Map<String, dynamic>
        : null;

    return OfferPricingModel(
      hasActiveOffer: _parseBool(json['has_active_offer']),
      minimumNights:
          _parseInt(json['minimum_nights'] ?? offerJson?['minimum_nights']),
      startsAt: json['starts_at']?.toString() ??
          offerJson?['starts_at']?.toString() ??
          '',
      endsAt: json['ends_at']?.toString() ??
          offerJson?['ends_at']?.toString() ??
          '',
      totalBeforeOffer: _parseNum(
        json['total_before_offer'] ?? json['totalBeforeOffer'],
      ),
      totalAfterOffer: _parseNum(
        json['total_after_offer'] ?? json['totalAfterOffer'],
      ),
      totalDiscountAmount: _parseNum(
        json['total_discount_amount'] ?? json['totalDiscountAmount'],
      ),
      basePricePerNight: _parseNum(json['base_price_per_night']),
      pricePerNight: _parseNum(json['price_per_night']),
      discountAmountPerNight: _parseNum(json['discount_amount_per_night']),
      offer: offerJson != null
          ? OfferDetailsModel.fromJson(offerJson)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'has_active_offer': hasActiveOffer,
      'minimum_nights': minimumNights,
      'starts_at': startsAt,
      'ends_at': endsAt,
      'total_before_offer': totalBeforeOffer,
      'total_after_offer': totalAfterOffer,
      'total_discount_amount': totalDiscountAmount,
      'base_price_per_night': basePricePerNight,
      'price_per_night': pricePerNight,
      'discount_amount_per_night': discountAmountPerNight,
      'offer': offer?.toJson(),
    };
  }

  factory OfferPricingModel.empty() {
    return const OfferPricingModel(
      hasActiveOffer: false,
      minimumNights: 0,
      startsAt: '',
      endsAt: '',
      totalBeforeOffer: 0,
      totalAfterOffer: 0,
      totalDiscountAmount: 0,
      basePricePerNight: 0,
      pricePerNight: 0,
      discountAmountPerNight: 0,
      offer: null,
    );
  }
}

