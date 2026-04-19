class DiscountPricingModel {
  final bool hasActiveDiscount;
  final String basePricePerNight;
  final String pricePerNight;

  const DiscountPricingModel({
    required this.hasActiveDiscount,
    required this.basePricePerNight,
    required this.pricePerNight,
  });

  bool get hasDiscount =>
      hasActiveDiscount &&
      basePricePerNight.isNotEmpty &&
      pricePerNight.isNotEmpty &&
      basePricePerNight != pricePerNight;

  factory DiscountPricingModel.fromJson(Map<String, dynamic> json) {
    return DiscountPricingModel(
      hasActiveDiscount: _parseBool(json['has_active_discount']),
      basePricePerNight: json['base_price_per_night']?.toString() ?? '',
      pricePerNight: json['price_per_night']?.toString() ?? '',
    );
  }

  factory DiscountPricingModel.empty() => const DiscountPricingModel(
        hasActiveDiscount: false,
        basePricePerNight: '',
        pricePerNight: '',
      );

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
