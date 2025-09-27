import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../properties/home/data/model/property_data_model.dart';
import '../../../user/data/model/auth_model.dart';
import '../source_data/remote_data_source.dart';

class ProfileReposaitory {
  final ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSource();

  Future<Either<DioException, AuthModel>> update(
    String phoneNumber,
    String name,
    String email,
    String gender,
    int cityId,
    DateTime? dateOfBirth,
  ) async {
    try {
      final remote = await profileRemoteDataSource.upDateUser(
          phoneNumber, name, email, gender, cityId, dateOfBirth);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<PropertyDataModel>>>
      getFavoriteProperties() async {
    try {
      final remote = await profileRemoteDataSource.getFavoriteProperties();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>>
  addFavoriteProperties({required int idProperties}) async {
    try {
      final remote = await profileRemoteDataSource.addFavoriteProperties(idProperties);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> logout() async {
    try {
      final remote = await profileRemoteDataSource.logout();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

}
