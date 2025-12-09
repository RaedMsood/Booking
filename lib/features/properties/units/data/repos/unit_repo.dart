import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/unit_data_source.dart';
import '../model/sections_model.dart';
import '../model/unit_details_model.dart';

class UnitReposaitory {
  final UnitDataSource _unitDetailsDataSource = UnitDataSource();

  Future<Either<DioException, UnitDetailsModel>> getUnitDetails({
    required int unitId,
  }) async {
    try {
      final remote =
          await _unitDetailsDataSource.getUnitDetails(unitId: unitId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, UnitsInPropertySectionsModel>> getAllUnits({
    required int propertyId,
    required int page,
    required int sectionId,
  }) async {
    try {
      final remote = await _unitDetailsDataSource.getAllUnits(
        page: page,
        propertyId: propertyId,
        sectionId: sectionId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
