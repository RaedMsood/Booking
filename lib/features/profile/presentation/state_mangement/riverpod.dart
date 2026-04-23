import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

    final safeName = (name ?? '').trim();
    final safeEmail = (email ?? '').trim();
    final safeGender = (gender ?? '').trim();
    final safeCityId = cityId ?? 0;

    final user = await _controller.update(
      safeName,
      safeEmail,
      safeGender,
      safeCityId,
      dateOfBirth,
    );

    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

class FavoritesState {
  final DataState<List<PropertyDataModel>> listState;
  final Set<int> ids;
  final Set<int> busyIds;

  const FavoritesState({
    required this.listState,
    this.ids = const <int>{},
    this.busyIds = const <int>{},
  });

  factory FavoritesState.initial() {
    return FavoritesState(
      listState: DataState<List<PropertyDataModel>>.initial(const []),
    );
  }

  bool isFavorite(int id) => ids.contains(id);
  bool isBusy(int id) => busyIds.contains(id);

  FavoritesState copyWith({
    DataState<List<PropertyDataModel>>? listState,
    Set<int>? ids,
    Set<int>? busyIds,
  }) {
    return FavoritesState(
      listState: listState ?? this.listState,
      ids: ids ?? this.ids,
      busyIds: busyIds ?? this.busyIds,
    );
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  FavoritesNotifier() : super(FavoritesState.initial()) {
    if (Auth().loggedIn) {
      refresh();
    }
  }

  final _controller = ProfileReposaitory();

  DataState<List<PropertyDataModel>> _nextListState(
    States stateData, {
    DioException? exception,
    List<PropertyDataModel>? data,
  }) {
    return state.listState.copyWith(
      state: stateData,
      exception: exception,
      data: data ?? state.listState.data,
    );
  }

  Set<int> _idsFromList(List<PropertyDataModel> list) {
    return list.map((property) => property.id).toSet();
  }

  List<PropertyDataModel> _normalizeFavorites(List<PropertyDataModel> list) {
    final map = <int, PropertyDataModel>{};
    for (final property in list) {
      map[property.id] = property.copyWith(isFavorite: true);
    }
    return map.values.toList();
  }

  Future<void> refresh({bool showLoading = true}) async {
    if (!Auth().loggedIn) {
      if (!mounted) return;
      state = FavoritesState.initial();
      return;
    }

    final previousData = state.listState.data;
    final previousIds = state.ids;

    if (showLoading) {
      state = state.copyWith(
        listState: _nextListState(States.loading, data: previousData),
      );
    }

    final response = await _controller.getFavoriteProperties();
    if (!mounted) return;

    response.fold(
      (failure) {
        if (previousData.isEmpty) {
          state = state.copyWith(
            listState: _nextListState(
              States.error,
              exception: failure,
              data: previousData,
            ),
            ids: previousIds,
          );
        } else {
          state = state.copyWith(
            listState: _nextListState(States.loaded, data: previousData),
            ids: previousIds,
          );
        }
      },
      (data) {
        final normalized = _normalizeFavorites(data);
        state = state.copyWith(
          listState: _nextListState(States.loaded, data: normalized),
          ids: _idsFromList(normalized),
        );
      },
    );
  }

  Future<void> toggle({
    required int id,
    PropertyDataModel? property,
  }) async {
    if (!Auth().loggedIn || state.isBusy(id)) return;

    final previousState = state;
    final wasFavorite = state.ids.contains(id);
    final nextIds = {...state.ids};
    final nextBusyIds = {...state.busyIds, id};
    final nextList = [...state.listState.data];

    if (wasFavorite) {
      nextIds.remove(id);
      nextList.removeWhere((item) => item.id == id);
    } else {
      nextIds.add(id);

      if (property != null) {
        final favoriteProperty = property.copyWith(isFavorite: true);
        final existingIndex = nextList.indexWhere((item) => item.id == id);
        if (existingIndex >= 0) {
          nextList[existingIndex] = favoriteProperty;
        } else {
          nextList.insert(0, favoriteProperty);
        }
      }
    }

    state = state.copyWith(
      ids: nextIds,
      busyIds: nextBusyIds,
      listState: _nextListState(States.loaded, data: nextList),
    );

    final response = await _controller.addFavoriteProperties(idProperties: id);
    if (!mounted) return;

    var succeeded = false;
    response.fold(
      (_) {
        state = previousState;
      },
      (_) {
        succeeded = true;
      },
    );

    if (!succeeded || !mounted) return;

    await refresh(showLoading: false);
    if (!mounted) return;

    final clearedBusyIds = {...state.busyIds}..remove(id);
    state = state.copyWith(busyIds: clearedBusyIds);
  }

  void clear() {
    if (!mounted) return;
    state = FavoritesState.initial();
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

    bool eqStr(String? a, String? b) => (a ?? '').trim() == (b ?? '').trim();

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
