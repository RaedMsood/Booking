import '../../../booking/data/booking_model/payment_methods_model.dart';
import '../../../properties/units/data/model/units_model.dart';
import 'invoice_model.dart';
import 'rate_model.dart';

class MyBookingsData {
  final int? id;
  final int? propertyId;
  final String? property;
  final String? status;
  final Address? address;
  final String? checkIn;
  final String? checkOut;
  final String? image;
  final int? unitCount;
  final int? adultCount;
  final int? childCount;
  final String? type;
  final dynamic deposit;
  final String? bookingAt;
  final String? code;
  final int? guests;
  final dynamic totalPrice;
  final List<RateModel>? rateData;
  final bool? isRated;
  final num? totalRate;
  final UnitsModel? unit;
  final PaymentMethodsModel? paymentMethods;
  final InvoiceModel? invoice;
  MyBookingsData({
    this.id,
    this.property,
    this.status,
    this.address,
    this.checkIn,
    this.checkOut,
    this.guests,
    this.totalPrice,
    this.image,
    this.type,
    this.unitCount,
    this.adultCount,
    this.childCount,
    this.bookingAt,
    this.deposit,
    this.code,
    this.propertyId,
    this.rateData,
    this.isRated,
    this.totalRate,
    this.unit,
    this.paymentMethods,
    this.invoice,
  });

  factory MyBookingsData.fromJson(Map<String, dynamic> json) {
    return MyBookingsData(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      property: json['property']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      checkIn: json['check_in']?.toString() ?? '',
      checkOut: json['check_out']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      guests: json['guests'] != null
          ? int.tryParse(json['guests'].toString())
          : null,
      totalPrice: json['total_price'] != null
          ? double.tryParse(json['total_price'].toString())
          : null,
      childCount: json['children'] ?? 0,
      adultCount: json['adults'] ?? 0,
      unitCount: json['count'] ?? 1,
      type: json['type']?.toString() ?? '',
      bookingAt: json['booking_at']?.toString() ?? '',
      deposit: json['deposit']?.toString() ?? '',
      code: json['trx_id'] ?? '',
      propertyId: json['property_id'] ?? 0,
      rateData: RateModel.fromJsonList(json['criterias'] ?? []),
      isRated: json['rate'] ?? false,
      totalRate: json['totalRate'] ?? 0,
      unit: json['unit'] == null
          ? UnitsModel.empty()
          : UnitsModel.fromJson(json['unit'] as Map<String, dynamic>),
      paymentMethods: json['payment_method'] == null
          ? PaymentMethodsModel.empty()
          : PaymentMethodsModel.fromJson(
              json['payment_method'] as Map<String, dynamic>),
      invoice: json['invoice'] != null
          ? InvoiceModel.fromJson(json['invoice'] as Map<String, dynamic>)
          : null,
    );
  }

  factory MyBookingsData.empty() {
    return MyBookingsData(
      propertyId: null,
      checkIn: '',
      checkOut: '',
      guests: null,
      childCount: 0,
      adultCount: 0,
      bookingAt: '',
      type: '',
      unitCount: null,
      paymentMethods: PaymentMethodsModel.empty(),
      unit: UnitsModel.empty(),
      invoice: null
    );
  }
}


class Address {
  final String? city;
  final String? district;
  final String? address;

  Address({this.city, this.district, this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city']?.toString(),
      district: json['district']?.toString(),
      address: json['address']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'district': district,
      'address': address,
    };
  }

  factory Address.empty() {
    return Address(
      city: '',
      address: '',
      district: '',
    );
  }
}