import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/state.dart';
import '../../../../core/state/data_state.dart';
import '../../data/model/auth_model.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../../data/repos/user_repo.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, DataState<AuthModel>>(
        (ref) => SignUpNotifier());

class SignUpNotifier extends StateNotifier<DataState<AuthModel>> {
  SignUpNotifier() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserReposaitory();

  Future<void> logInOrSignUp({
    required String phoneNumber,
    required String name,
    String? email,
    required String gender,
    required int cityId,
    DateTime? dateOfBirth,
    String? deviceToken

  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.signUp(
        phoneNumber, name, email.toString(), gender, cityId, dateOfBirth,deviceToken!);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final checkOTPProvider =
    StateNotifierProvider.autoDispose<CheckOTPNotifier, DataState<AuthModel>>(
        (ref) => CheckOTPNotifier());

class CheckOTPNotifier extends StateNotifier<DataState<AuthModel>> {
  CheckOTPNotifier() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserReposaitory();

  Future<void> checkOTP({
    required String phoneNumber,
    required String otp,
    String? deviceToken
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.checkOTP(phoneNumber, otp,deviceToken!);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final userProvider =
    StateNotifierProvider.autoDispose<UserNotifier, DataState<bool>>(
        (ref) => UserNotifier());

class UserNotifier extends StateNotifier<DataState<bool>> {
  UserNotifier() : super(DataState<bool>.initial(false));
  final _controller = UserReposaitory();

  Future<void> logIn({
    required String phoneNumber,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.logIn(phoneNumber);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }

  Future<void> resendOTP({
    required String phoneNumberOrEmail,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.resendOTP(phoneNumberOrEmail);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}


