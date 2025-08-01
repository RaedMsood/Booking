import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../home/data/model/property_model.dart';
import '../data_source/cities_data_source.dart';
import '../model/city_model.dart';

class CitiesReposaitory {
  final CitiesRemoteDataSource _citiesRemoteDataSource = CitiesRemoteDataSource();

  Future<Either<DioException, List<CityModel>>> getAllCities() async {
    try {
      final remote = await _citiesRemoteDataSource.getAllCities();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, PropertyModel>> getPropertiesByCity({
    required int page,
    required int cityId,
  }) async {
    try {
      final remote = await _citiesRemoteDataSource.getPropertiesByCity(
        page: page,
        cityId: cityId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
