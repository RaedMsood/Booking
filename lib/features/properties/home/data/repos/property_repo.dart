import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/property_remote_data_source.dart';
import '../model/property_model.dart';

class PropertyReposaitory {
  final PropertyRemoteDataSource _propertyRemoteDataSource =
      PropertyRemoteDataSource();

  Future<Either<DioException, PropertyModel>> getAllProperty({
    required int page,
  }) async {
    try {
      final remote = await _propertyRemoteDataSource.getAllProperty(page: page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }


}
