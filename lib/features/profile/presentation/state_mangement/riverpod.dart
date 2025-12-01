import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../../../user/data/model/auth_model.dart';
import '../../data/model/profile_model.dart';
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

final updateNotifierProvider =
    StateNotifierProvider.autoDispose<UpdateNotifier, DataState<AuthModel>>(
        (ref) => UpdateNotifier());

class UpdateNotifier extends StateNotifier<DataState<AuthModel>> {
  UpdateNotifier() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = ProfileReposaitory();

  Future<void> update({
    String? name,
    String? email,
    String? gender,
    int? cityId,
    DateTime? dateOfBirth,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.update(
        name!, email.toString(), gender!, cityId!, dateOfBirth);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final favoriteProvider = StateNotifierProvider.autoDispose<FavoriteNotifier,
    DataState<List<PropertyDataModel>>>((ref) => FavoriteNotifier());

class FavoriteNotifier
    extends StateNotifier<DataState<List<PropertyDataModel>>> {
  FavoriteNotifier() : super(DataState<List<PropertyDataModel>>.initial([])) {
    getFavoriteProperties();
  }

  final _controller = ProfileReposaitory();

  Future<void> getFavoriteProperties() async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.getFavoriteProperties();
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final addFavoriteProvider =
    StateNotifierProvider.autoDispose<AddFavoriteNotifier, DataState<Unit>>(
        (ref) => AddFavoriteNotifier());

class AddFavoriteNotifier extends StateNotifier<DataState<Unit>> {
  AddFavoriteNotifier() : super(DataState<Unit>.initial(unit));
  final _controller = ProfileReposaitory();

  Future<void> addFavorite({required int idProperties}) async {
    state = state.copyWith(state: States.loading);
    final fav =
        await _controller.addFavoriteProperties(idProperties: idProperties);
    fav.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

class EditProfileController extends StateNotifier<ChangeResult> {
  EditProfileController() : super(const ChangeResult());

  ProfileModel? _initial;

  void initialize(ProfileModel snapshot) {
    _initial = snapshot;
    state = const ChangeResult();
  }

  void compute(ProfileModel current) {
    final init = _initial;
    if (init == null) return;

    bool eqStr(String a, String b) => a.trim() == b.trim();
    bool eqDate(DateTime? a, DateTime? b) {
      if (a == null && b == null) return true;
      if (a == null || b == null) return false;
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    state = ChangeResult(
      nameChanged: !eqStr(current.name, init.name),
      emailChanged: !eqStr(current.email, init.email),
      genderChanged: current.gender != init.gender,
      birthDateChanged: !eqDate(current.birthDate, init.birthDate),
      cityChanged: (current.city?.id) != (init.city?.id),
    );
  }

  ProfileModel effectiveForPut(ProfileModel current) {
    final init = _initial!;
    return ProfileModel(
      name: state.nameChanged ? current.name : init.name,
      email: state.emailChanged ? current.email : init.email,
      gender: state.genderChanged ? current.gender : init.gender,
      birthDate: state.birthDateChanged ? current.birthDate : init.birthDate,
      city: state.cityChanged ? current.city : init.city,
    );
  }
}

final editProfileControllerProvider =
    StateNotifierProvider<EditProfileController, ChangeResult>(
  (ref) => EditProfileController(),
);

class FavoriteIdsNotifier extends StateNotifier<Set<int>> {
  FavoriteIdsNotifier() : super(<int>{});

  final _repo = ProfileReposaitory();
  final Map<int, bool> _inFlight = {};

  bool isBusy(int id) => _inFlight[id] == true;

  Future<void> load() async {
    final res = await _repo.getFavoriteProperties();
    res.fold((_) {}, (list) {
      state = list.map((p) => p.id).toSet();
    });
  }

  Future<void> toggle(int id) async {
    if (_inFlight[id] == true) return;
    _inFlight[id] = true;

    final wasFav = state.contains(id);
    state = wasFav ? ({...state}..remove(id)) : ({...state, id});

    try {
      final res = await _repo.addFavoriteProperties(idProperties: id); // toggle
      res.fold(
        (_) {
          state = wasFav ? ({...state, id}) : ({...state}..remove(id));
        },
        (_) {},
      );
    } finally {
      _inFlight[id] = false;
    }
  }
}

final favoriteIdsProvider =
    StateNotifierProvider<FavoriteIdsNotifier, Set<int>>(
  (ref) => FavoriteIdsNotifier()..load(),
);
final logoutProvider =
    StateNotifierProvider.autoDispose<LogoutController, DataState<Unit>>(
  (ref) {
    return LogoutController();
  },
);

class LogoutController extends StateNotifier<DataState<Unit>> {
  LogoutController() : super(DataState<Unit>.initial(unit));
  final _controller = ProfileReposaitory();

  Future<void> logout() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.logout();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> deleteAccount() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.deleteAccount();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

final changePhoneNumberProvider = StateNotifierProvider.autoDispose<
    ChangePhoneNumberController, DataState<AuthModel>>(
  (ref) {
    return ChangePhoneNumberController();
  },
);

class ChangePhoneNumberController extends StateNotifier<DataState<AuthModel>> {
  ChangePhoneNumberController()
      : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = ProfileReposaitory();

  Future<void> confirmChangePhoneNumber({
    required String phoneNumber,
    required String otp,
  }) async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.confirmChangePhoneNumber(
      phoneNumber: phoneNumber,
      otp: otp,
    );
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }

  Future<void> changePhoneNumber({required String phoneNumber}) async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.changePhoneNumber(phoneNumber: phoneNumber);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}
