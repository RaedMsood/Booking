import '../../../../offers/data/model/offer_pricing_model.dart';

class UnitsModel {

  final int id;
  final String name;
  final String price;
  final int maxGuests;
  final String? description;
  final String? image;
  final num singleBed;
  final num doubleBed;
  final OfferPricingModel? offerPricing;

  UnitsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.maxGuests,
    this.description,
    this.image,
    required this.singleBed,
    required this.doubleBed,
    this.offerPricing,
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

  bool get hasDiscount {
    final pricing = offerPricing;
    if (pricing == null) return false;
    return pricing.hasActiveOffer &&
        pricing.basePricePerNight > 0 &&
        pricing.pricePerNight > 0 &&
        pricing.basePricePerNight != pricing.pricePerNight;
  }

  String get effectivePrice {
    final discountedPrice = offerPricing?.pricePerNight;
    if ((discountedPrice ?? 0) > 0) {
      return discountedPrice.toString();
    }
    return price;
  }

  String? get originalPriceBeforeDiscount {
    if (!hasDiscount) return null;
    final basePrice = offerPricing?.basePricePerNight;
    if ((basePrice ?? 0) <= 0) return null;
    return basePrice.toString();
  }

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    final pricingJson = json['offer_pricing'] is Map<String, dynamic>
        ? json['offer_pricing']
        : (json['discount_pricing'] is Map<String, dynamic>
            ? json['discount_pricing']
            : null);

    return UnitsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      price: json['price_per_night']?.toString() ?? '',
      maxGuests: json['max_guests'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      singleBed: json['single_beds'] ?? json['single_bed'] ?? 0,
      doubleBed: json['double_beds'] ?? json['double_bed'] ?? 0,
      offerPricing: pricingJson is Map<String, dynamic>
          ? OfferPricingModel.fromJson(pricingJson)
          : null,
    );
  }

  static List<UnitsModel> fromJsonList(List json) {
    return json.map((e) => UnitsModel.fromJson(e)).toList();
  }

  factory UnitsModel.empty() => UnitsModel(
        id: 0,
        name: '',
        price: '',
        maxGuests: 0,
        description: null,
        image: null,
        singleBed: 0,
        doubleBed: 0,
        offerPricing: null,
      );
}
