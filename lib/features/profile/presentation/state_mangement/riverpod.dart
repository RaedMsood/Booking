import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../../../user/data/model/auth_model.dart';
import '../../data/reposaitory/profile_reposaitory.dart';

final languageProvider =
    StateNotifierProvider<LanguageController, Locale>((ref) {
  return LanguageController();
});

class LanguageController extends StateNotifier<Locale> {
  LanguageController() : super(const Locale('ar')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final savedLanguage = await Auth().getLanguage();
      state = Locale(savedLanguage);
    } catch (e) {
      state = const Locale('ar');
      debugPrint("Error loading language: $e");
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      await Auth().setLanguage(languageCode);
      state = Locale(languageCode);
    } catch (e) {
      debugPrint("Error changing language: $e");
    }
  }
}

final editProfileProvider =
    StateNotifierProvider.autoDispose<EditProfileNotifier, bool>(
  (ref) => EditProfileNotifier(ref),
);

class EditProfileNotifier extends StateNotifier<bool> {
  EditProfileNotifier(this.ref) : super(false);

  final Ref ref;

  late final String _originalName;
  late final String _originalEmail;
  String? _originalGender;
  DateTime? _originalBirthDate;
  CityModel? _originalCity;

  void initialize({
    required String name,
    required String email,
    required String? gender,
    required DateTime? birthDate,
    required CityModel? city,
  }) {
    _originalName = name;
    _originalEmail = email;
    _originalGender = gender;
    _originalBirthDate = birthDate;
    _originalCity = city;
  }

  void checkIfChanged({
    required String name,
    required String email,
    required String? gender,
    required DateTime? birthDate,
    required CityModel? city,
  }) {
    final changed = name.trim() != _originalName.trim() ||
        email.trim() != _originalEmail.trim() ||
        gender != _originalGender ||
        birthDate != _originalBirthDate ||
        city?.id != _originalCity?.id;

    if (changed != state) state = changed;
  }
}

final updateNotifierProvider =
    StateNotifierProvider.autoDispose<UpdateNotifier, DataState<AuthModel>>(
        (ref) => UpdateNotifier());

class UpdateNotifier extends StateNotifier<DataState<AuthModel>> {
  UpdateNotifier() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = ProfileReposaitory();

  Future<void> update({
    required String phoneNumber,
    required String name,
    String? email,
    required String gender,
    required int cityId,
    DateTime? dateOfBirth,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.update(
        phoneNumber, name, email.toString(), gender, cityId, dateOfBirth);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
