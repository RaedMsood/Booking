class BookingData {
  final int? id;
  final int? unitId;
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
  final Customer? customer;

  BookingData(
      {this.id,
      this.unitId,
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
      this.customer,
      this.childCount,
        this.bookingAt,
        this.deposit,
        this.code
      });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      unitId: json['unit_id'] != null
          ? int.tryParse(json['unit_id'].toString())
          : null,
      property: json['property']?.toString()??'',
      status: json['status']?.toString()??'',
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      checkIn: json['check_in']?.toString()??'',
      checkOut: json['check_out']?.toString()??'',
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
      type: json['type']?.toString()??'',
      bookingAt: json['booking_at']?.toString()??'',
      deposit: json['deposit']?.toString()??'',

      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : null,
      code: json['code']??''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_id': unitId,
      'property': property,
      'status': status,
      'address': address?.toJson(),
      'check_in': checkIn,
      'check_out': checkOut,
      'guests': guests,
      'total_price': totalPrice,
      'children': childCount,
      'adults': adultCount,
      'count': unitCount,
      'type': type,
      //'customer': customer?.toJson(),
    };
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
}

class Customer {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final int? bookingId;

  const Customer({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.bookingId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      bookingId: json['booking_id'] != null
          ? int.tryParse(json['booking_id'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'booking_id': bookingId,
    };
  }
}
