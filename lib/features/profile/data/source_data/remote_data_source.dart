import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../user/data/model/auth_model.dart';

class ProfileRemoteDataSource {
  Future<AuthModel> upDateUser(
    String phoneNumber,
    String name,
    String email,
    String gender,
    int cityId,
    DateTime? dateOfBirth,
  ) async {
    final response = await RemoteRequest.postData(
      path: AppURL.updateUser,
      data: {
        "phone": phoneNumber,
        "name": name,
        if (email.isNotEmpty) 'email': email,
        "gender": gender,
        "city_id": cityId,
        if (dateOfBirth != null) "date_of_birth": dateOfBirth.toIso8601String(),
      },
    );
    return AuthModel.fromJson(response.data['data']);
  }
}
