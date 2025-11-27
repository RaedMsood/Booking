import '../../../properties/cities/data/model/city_model.dart';

class ProfileModel {
  final String name;
  final String email;
  final dynamic gender;
  final DateTime? birthDate;
  final CityModel? city;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.city,
  });
}
class ChangeResult {
  final bool nameChanged;
  final bool emailChanged;
  final bool genderChanged;
  final bool birthDateChanged;
  final bool cityChanged;

  const ChangeResult({
    this.nameChanged = false,
    this.emailChanged = false,
    this.genderChanged = false,
    this.birthDateChanged = false,
    this.cityChanged = false,
  });

  bool get hasAny =>
      nameChanged ||
          emailChanged ||
          genderChanged ||
          birthDateChanged ||
          cityChanged;
}
