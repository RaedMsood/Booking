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
    this.pricePerNight,
    this.type,
    this.unitCount,
    this.adultCount,
    this.childCount,
    this.bookingAt,
    this.deposit,
    this.unitName,
  });

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
      totalPrice: json['total_price'] != null
          ? double.tryParse(json['total_price'].toString())
          : null,
      adultCount: json['adults'] ?? 0,
      childCount: json['children'] ?? 0,
      pricePerNight: json['price_per_night'] != null
          ? double.tryParse(json['price_per_night'].toString())
          : null,
      type: json['type'] ?? '',
      bookingAt: json['created_at'] ?? '',
      deposit: json['deposit'] != null
          ? double.tryParse(json['deposit'].toString())
          : null,
      unitName: json['unit_name'] ?? '',
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
      childCount: 0,
      adultCount: 0,
      bookingAt: '',
      type: '',
      unitCount: null,
      unitName: '',
    );
  }
}
