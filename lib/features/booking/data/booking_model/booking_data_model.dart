import 'booking_data.dart';

class BookingDataModel {
  final BookingData bookingData;
  final Customer? customer;

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
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : Customer.empty(),
    );
  }

  factory BookingDataModel.empty() {
    return BookingDataModel(
      bookingData: BookingData.empty(),
      customer: Customer.empty(),
    );
  }
}



class Customer {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final BookingData? booking;

  const Customer({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.booking,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
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
      'booking_id': booking?.toJson(),
    };
  }

  factory Customer.empty() {
    return Customer(
      name: '',
      address: '',
      booking: BookingData.empty(),
      email: '',
      phone: '',
    );
  }
}
