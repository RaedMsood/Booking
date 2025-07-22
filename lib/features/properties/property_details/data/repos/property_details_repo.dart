import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/property_details_data_source.dart';
import '../models/property_details_model.dart';

class PropertyDetailsReposaitory {
  final PropertyDetailsDataSource _propertyDetailsDataSource =
      PropertyDetailsDataSource();

  Future<Either<DioException, PropertyDetailsModel>> getPropertyDetails({
    required int id,
  }) async {
    try {
      final remote =
          await _propertyDetailsDataSource.getPropertyDetails(id: id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
