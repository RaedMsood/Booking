class AddressModel {
  final String city;
  final String district;
  final String address;
  final dynamic lat;
  final dynamic lng;

  AddressModel({
    required this.city,
    required this.district,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'] ??'',
      district: json['district'] ??'',
      address: json['address'] ??'',
      lat: json['lat']??15.369445,
      lng: json['lng']??44.191006,
    );
  }

  factory AddressModel.empty() => AddressModel(
        city: '',
        district: '',
        address: '',
        lat: 15.369445,
        lng: 44.191006,
      );
}
