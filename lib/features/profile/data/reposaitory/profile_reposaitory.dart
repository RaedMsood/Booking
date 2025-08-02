import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../user/data/model/auth_model.dart';
import '../source_data/remote_data_source.dart';

class ProfileReposaitory{
  final ProfileRemoteDataSource profileRemoteDataSource =ProfileRemoteDataSource();

  Future<Either<DioException, AuthModel>> update(
      String phoneNumber,
      String name,
      String email,
      String gender,
      int cityId,
      DateTime? dateOfBirth,
      ) async {
    try {
      final remote = await profileRemoteDataSource.upDateUser(phoneNumber, name, email, gender, cityId, dateOfBirth);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}