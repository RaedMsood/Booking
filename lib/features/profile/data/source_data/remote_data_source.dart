import 'package:dartz/dartz.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../../../user/data/model/auth_model.dart';

class ProfileRemoteDataSource {
  Future<AuthModel> upDateUser(
    String name,
    String email,
    String gender,
    int cityId,
    DateTime? dateOfBirth,
  ) async {
    final response = await RemoteRequest.postData(
      path: AppURL.updateUser,
      data: {
        "name": name,
        if (email.isNotEmpty) 'email': email,
        "gender": gender,
        "city_id": cityId,
        if (dateOfBirth != null) "date_of_birth": dateOfBirth.toIso8601String(),
      },
    );
    return AuthModel.fromJson(response.data['data']);
  }

  Future<List<PropertyDataModel>> getFavoriteProperties() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getFavorite,
    );
    return PropertyDataModel.fromJsonList(response.data['data']);
  }

  Future<Unit> addFavoriteProperties(int idProperties) async {
    await RemoteRequest.postData(
        path: AppURL.addFavorite, data: {'property_id': idProperties});
    return Future.value(unit);
  }

  Future<Unit> changePhoneNumber({
    required String phoneNumber,
  }) async {
    await RemoteRequest.postData(
      path: AppURL.changePhoneNumber,
      data: {
        "phone": phoneNumber,
      },
    );
    return Future.value(unit);
  }

  Future<AuthModel> confirmChangePhoneNumber({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.confirmChangePhoneNumber,
      data: {
        "phone": phoneNumber,
        "otp": otp,
      },
    );
    return AuthModel.fromJson(response.data['data']);
  }

  Future<Unit> logout() async {
    await RemoteRequest.postData(
      path: AppURL.logout,
    );
    return Future.value(unit);
  }

  Future<Unit> deleteAccount() async {
    await RemoteRequest.deleteData(
      path: AppURL.deleteAccount,
    );
    return Future.value(unit);
  }
}
// eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIwMTk3Y2M5NS04Njk5LTcwMzgtYjBlNy1kZjYyNDI3ZTUwNmMiLCJqdGkiOiI3NWJiYWNhZTJkODExOGVjYTIxOTdjY2I1MmQ1ZWI3ZGE3Y2M0NWVkYjE0ZmQwOWZjMmEzMTUzZTg4OWZhOGE2NGVkYzk3ZmI0YjFkMmVlZiIsImlhdCI6MTc2NDU1MDI3OC45NzQ4MTEsIm5iZiI6MTc2NDU1MDI3OC45NzQ4MTMsImV4cCI6MTc5NjA4NjI3OC45NzMyMzgsInN1YiI6IjYiLCJzY29wZXMiOltdfQ.GzyT-jFExLK_Ij2hRbQGxpXgM4l7OB1Bm15b1lqdFuITnRZO5nuodqAPJSC_FKZcmuG94OShkk5sXDLJaihIKf-vCg2--XQH5wDc4-4W8yX0cOE_Mga-I01NVj8EvFgbhYzwgOY-BVrbX4MagSiko_wyDNKNj-fhd1NrWvilQM_UoICxbTOMo1dUSJ3YfzJeopbovHab4nYOCAQuEHcvb-BsKFI6tnNGXnHqqwYKN8SfMW19HvD1-5PpJucXNGvQ9Sy_gjisY4TtTZ0I9Wt4nDdgZKxWtCfV0uN7hAoFSCELVdGUffqrB0R8fuNaNCicaHxEQc8RQnRJ4ifWg5PmtCnlC42KlIb3Zifz14XareRHNoFaruDMdQSFlUQzeWa3zfiekDFugu6kz9psqOx4vmp8DRxp2mdi95GnP3sMOX5XgwEdxQMH3Kw4jHaxy3T5E6pUnjRDpIPM-9iOX3tAIMqngHAEM6O06Ul9MqzFotY5pdo7DcO8EEBUQcecUoByrUEf_FhSH2ph8qavMEHMSzUT-Ucv6VaYQpnRixpr4m60DNfAIf8e9wzIB_CdxUWyaXOACE-NG6gi1hTQPDkpHDx1lhmiYJB6XKl5CRtDcdNXtWiWGZyEjBwjVHt8nRwKv9PuxD54Lw9D3hkYT9-HIwsfeSb1RfVC
