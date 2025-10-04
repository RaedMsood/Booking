import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../data_source/map_remote_data_source.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../model/position_properties_model.dart';

class MapReposaitory {
  final MapRemoteDataSource _mapRemoteDataSource = MapRemoteDataSource();

  Future<Either<DioException, List<PositionPropertiesModel>>>
  getPropertiesProperties() async {
    try {
      final remote = await _mapRemoteDataSource.getPositionProperties();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, PropertyDataModel>>
  getPropertiesFromPosition({required int idProperty}) async {
    try {
      final remote = await _mapRemoteDataSource.getPropertiesFromPosition(idProperty);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

}
