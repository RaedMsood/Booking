import 'booking_data.dart';

class BookingDataModel {
  final BookingData bookingData;
  final CustomerModel? customer;

  BookingDataModel({
    required this.bookingData,
    required this.customer,
  });

  factory BookingDataModel.fromJson(Map<String, dynamic> json) {
    return BookingDataModel(
      bookingData: json['booking'] != null
          ? BookingData.fromJson(json['booking'] as Map<String, dynamic>)
          : BookingData.empty(),
      customer: json['customer'] != null
          ? CustomerModel.fromJson(json['customer'] as Map<String, dynamic>)
          : CustomerModel.empty(),
    );
  }

  factory BookingDataModel.empty() {
    return BookingDataModel(
      bookingData: BookingData.empty(),
      customer: CustomerModel.empty(),
    );
  }
}

class CustomerModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final BookingData? booking;

  const CustomerModel({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.booking,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      if (booking != null) 'booking_id': booking?.toJson(),
    };
  }

  factory CustomerModel.empty() {
    return const CustomerModel(
      name: '',
      address: '',
      email: '',
      phone: '',
    );
  }
}
