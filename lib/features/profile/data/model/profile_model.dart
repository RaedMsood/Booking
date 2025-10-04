import '../../../properties/cities/data/model/city_model.dart';

class ProfileModel {
  final String name;
  final String email; // اختياري
  final String phoneNumber; // غالباً إجباري
  final dynamic gender; // اختياري
  final DateTime? birthDate; // اختياري
  final CityModel? city; // غالباً إجباري

  const ProfileModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.city,
  });
}
class ChangeResult {
  final bool nameChanged;
  final bool emailChanged;
  final bool phoneChanged;
  final bool genderChanged;
  final bool birthDateChanged;
  final bool cityChanged;

  const ChangeResult({
    this.nameChanged = false,
    this.emailChanged = false,
    this.phoneChanged = false,
    this.genderChanged = false,
    this.birthDateChanged = false,
    this.cityChanged = false,
  });

  bool get hasAny =>
      nameChanged ||
          emailChanged ||
          phoneChanged ||
          genderChanged ||
          birthDateChanged ||
          cityChanged;
}
