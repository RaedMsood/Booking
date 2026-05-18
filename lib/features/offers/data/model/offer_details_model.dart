class OfferDetailsModel {
  final int id;
  final String title;
  final String type;
  final num value;
  final int minimumNights;
  final String startsAt;
  final String endsAt;
  final num discountAmount;
  final num priceBeforeOffer;
  final num priceAfterOffer;
  final String providerType;
  final String costBearer;
  final String? giftDescription;

  const OfferDetailsModel({
    required this.id,
    required this.title,
    required this.type,
    required this.value,
    required this.minimumNights,
    required this.startsAt,
    required this.endsAt,
    required this.discountAmount,
    required this.priceBeforeOffer,
    required this.priceAfterOffer,
    required this.providerType,
    required this.costBearer,
    required this.giftDescription,
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

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailsModel(
      id: _parseInt(json['id']),
      title: json['offer_description']?.toString() ??
          json['offer_title']?.toString() ??
          json['offer_description']?.toString() ??
          '',
      type: json['type']?.toString() ?? '',
      value: _parseNum(json['value']),
      minimumNights: _parseInt(json['minimum_nights']),
      startsAt: json['starts_at']?.toString() ?? '',
      endsAt: json['ends_at']?.toString() ?? '',
      discountAmount: _parseNum(json['discount_amount']),
      priceBeforeOffer: _parseNum(json['price_before_offer']),
      priceAfterOffer: _parseNum(json['price_after_offer']),
      providerType: json['provider_type']?.toString() ?? '',
      costBearer: json['cost_bearer']?.toString() ?? '',
      giftDescription: json['gift_description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'value': value,
      'minimum_nights': minimumNights,
      'starts_at': startsAt,
      'ends_at': endsAt,
      'discount_amount': discountAmount,
      'price_before_offer': priceBeforeOffer,
      'price_after_offer': priceAfterOffer,
      'provider_type': providerType,
      'cost_bearer': costBearer,
      'gift_description': giftDescription,
    };
  }

  factory OfferDetailsModel.empty() {
    return const OfferDetailsModel(
      id: 0,
      title: '',
      type: '',
      value: 0,
      minimumNights: 0,
      startsAt: '',
      endsAt: '',
      discountAmount: 0,
      priceBeforeOffer: 0,
      priceAfterOffer: 0,
      providerType: '',
      costBearer: '',
      giftDescription: null,
    );
  }
}

