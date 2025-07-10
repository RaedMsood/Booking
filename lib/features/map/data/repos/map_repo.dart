import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/map_remote_data_source.dart';
import '../../../map/data/model/city_model.dart';

class MapReposaitory {
  final MapRemoteDataSource _mapRemoteDataSource = MapRemoteDataSource();

  Future<Either<DioException, List<CityModel>>> getCities() async {
    try {
      final remote = await _mapRemoteDataSource.getCities();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
