import '../../../map/data/model/city_model.dart';

class UserModel {
  final int id;
  final String name;

  // final String email;
  final String phoneNumber;

  // final String gender;
  // final String brithDay;
  final CityModel? city;

  UserModel({
    required this.id,
    required this.name,
    // required this.email,
    required this.phoneNumber,
    // required this.gender,
    // required this.brithDay,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      // email: json['email'] ?? "",
      phoneNumber: json['phone'] ?? "",
      // gender: json['gender'] ?? "",
      // brithDay: json['brith_day'] ?? "",
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phoneNumber,
      'city': city,
    };
  }

  UserModel copyWith() {
    return UserModel(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      city: city,
    );
  }

  factory UserModel.empty() => UserModel(
        id: 0,
        name: '',
        // email: '',
        phoneNumber: '',
        // gender: '',
        // brithDay: '',
        city: CityModel.empty(),
      );
}
