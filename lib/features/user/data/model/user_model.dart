import '../../../properties/cities/data/model/city_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? birthDay;
  final CityModel? city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDay,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone'] ?? "",
      gender: json['gender'] ?? "",
      birthDay: json['birth_day'],
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'gender': gender,
      'birth_day': birthDay,
      'city_id': city?.id,
    };
  }
  /// للتحويل إلى JSON للتخزين المحلي (يشمل كائن المدينة كاملاً)
  Map<String, dynamic> toJsonForCache() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'gender': gender,
      'birth_day': birthDay,
      // خزن كائن المدينة كاملاً
      'city': city?.toJson(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? birthDay,
    CityModel? city,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      city: city ?? this.city,
    );
  }

  factory UserModel.empty() => UserModel(
    id: 0,
    name: '',
    email: '',
    phoneNumber: '',
    gender: '',
    birthDay: '',
    city: CityModel.empty(),
  );
}
