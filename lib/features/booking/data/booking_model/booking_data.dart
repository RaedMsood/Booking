import '../../../offers/data/model/offer_pricing_model.dart';

class BookingData {
  final int? propertyId;
  final int? userId;
  final int? unitId;
  final String? checkIn;
  final String? checkOut;
  final int? unitCount;
  final int? adultCount;
  final int? childCount;
  final String? type;
  final dynamic deposit;
  final String? bookingAt;
  final int? guests;
  final dynamic totalPrice;
  final dynamic price;
  final bool hasDiscount;
  final OfferPricingModel? offerPricing;
  final dynamic pricePerNight;
  final String? unitName;

  BookingData({
    this.propertyId,
    this.userId,
    this.unitId,
    this.checkIn,
    this.checkOut,
    this.guests,
    this.totalPrice,
    this.price,
    this.hasDiscount = false,
    this.offerPricing,
    this.pricePerNight,
    this.type,
    this.unitCount,
    this.adultCount,
    this.childCount,
    this.bookingAt,
    this.deposit,
    this.unitName,
  });

  bool get hasActiveOffer => offerPricing?.hasActiveOffer ?? false;

  int get minimumNights => offerPricing?.minimumNights ?? 0;

  String get startsAt => offerPricing?.startsAt ?? '';

  String get endsAt => offerPricing?.endsAt ?? '';

  String get offerDescription {
    final offer = offerPricing?.offer;
    final giftDescription = offer?.giftDescription?.trim() ?? '';
    if (giftDescription.isNotEmpty) return giftDescription;
    final title = offer?.title.trim() ?? '';
    if (title.isNotEmpty) return title;
    return '';
  }

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      propertyId: json['property_id'],
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
      unitId: json['unit_id'] != null
          ? int.tryParse(json['unit_id'].toString())
          : null,
      checkIn: json['check_in']?.toString() ?? '',
      checkOut: json['check_out']?.toString() ?? '',
      unitCount: json['count'] ?? 1,
      guests: json['guests'] != null
          ? int.tryParse(json['guests'].toString())
          : null,
      totalPrice: _parseAmount(json['total_price']),
      price: _parseAmount(json['price']) ?? _parseAmount(json['total_price']),
      hasDiscount: _parseBool(json['has_discount'] ?? json['hasDiscount']),
      offerPricing: json['offer_pricing'] is Map<String, dynamic>
          ? OfferPricingModel.fromJson({
              ...json['offer_pricing'] as Map<String, dynamic>,
              'total_before_offer': json['total_before_offer'] ?? json['totalBeforeOffer'],
              'total_after_offer': json['total_after_offer'] ?? json['totalAfterOffer'],
              'total_discount_amount': json['total_discount_amount'] ?? json['totalDiscountAmount'],
            })
          : null,
      adultCount: json['adults'] ?? 0,
      childCount: json['children'] ?? 0,
      pricePerNight: _parseAmount(json['price_per_night']),
      type: json['type'] ?? '',
      bookingAt: json['created_at'] ?? '',
      deposit: _parseAmount(json['deposit']),
      unitName: json['unit_name'] ?? '',
    );
  }

  BookingData copyWith({
    int? propertyId,
    int? userId,
    int? unitId,
    String? checkIn,
    String? checkOut,
    int? unitCount,
    int? adultCount,
    int? childCount,
    String? type,
    dynamic deposit,
    String? bookingAt,
    int? guests,
    dynamic totalPrice,
    dynamic price,
    bool? hasDiscount,
    OfferPricingModel? offerPricing,
    dynamic pricePerNight,
    String? unitName,
  }) {
    return BookingData(
      propertyId: propertyId ?? this.propertyId,
      userId: userId ?? this.userId,
      unitId: unitId ?? this.unitId,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      unitCount: unitCount ?? this.unitCount,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      type: type ?? this.type,
      deposit: deposit ?? this.deposit,
      bookingAt: bookingAt ?? this.bookingAt,
      guests: guests ?? this.guests,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
      hasDiscount: hasDiscount ?? this.hasDiscount,
      offerPricing: offerPricing ?? this.offerPricing,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      unitName: unitName ?? this.unitName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_id': propertyId,
      'unit_id': unitId,
      'user_id': userId,
      'check_in': checkIn,
      'check_out': checkOut,
      'guests': guests,
      'total_price': totalPrice,
      'price': price,
      'total_before_offer': resolvedTotalBeforeOffer,
      'total_after_offer': resolvedTotalAfterOffer,
      'total_discount_amount': resolvedTotalDiscountAmount,
      'has_discount': hasDiscount,
      'has_active_offer': hasActiveOffer,
      'offer_description': offerDescription,
      'offer_pricing': offerPricing?.toJson(),
      'price_per_night': pricePerNight,
      'children': childCount,
      'adults': adultCount,
      'count': unitCount,
      'type': type,
      'created_at': bookingAt,
      'unit_name': unitName,
      'deposit': deposit,
    };
  }

  factory BookingData.empty() {
    return BookingData(
      propertyId: null,
      userId: null,
      unitId: null,
      checkIn: '',
      checkOut: '',
      guests: null,
      totalPrice: null,
      price: null,
      hasDiscount: false,
      offerPricing: null,
      childCount: 0,
      adultCount: 0,
      bookingAt: '',
      type: '',
      unitCount: null,
      unitName: '',
    );
  }

  double? get displayPrice {
    if (hasDiscount) {
      return _parseAmount(totalPrice) ?? _parseAmount(price);
    }
    return _parseAmount(price) ?? _parseAmount(totalPrice);
  }

  double? get originalPriceBeforeDiscount {
    if (!hasDiscount) return null;
    final original = _parseAmount(price);
    final current = displayPrice;
    if (original == null || current == null || original == current) return null;
    return original;
  }

  double? get resolvedTotalBeforeOffer {
    final direct = offerPricing?.totalBeforeOffer;
    if ((direct ?? 0) > 0) return direct!.toDouble();
    return originalPriceBeforeDiscount ?? _parseAmount(price);
  }

  double? get resolvedTotalAfterOffer {
    final direct = offerPricing?.totalAfterOffer;
    if ((direct ?? 0) > 0) return direct!.toDouble();
    return displayPrice ?? _parseAmount(totalPrice);
  }

  double? get resolvedTotalDiscountAmount {
    final direct = offerPricing?.totalDiscountAmount;
    if ((direct ?? 0) > 0) return direct!.toDouble();

    final before = resolvedTotalBeforeOffer;
    final after = resolvedTotalAfterOffer;
    if (before == null || after == null) return null;

    final diff = before - after;
    if (diff <= 0) return null;
    return diff;
  }

  static double? _parseAmount(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == 'true' || normalized == '1';
    }
    return false;
  }
}
