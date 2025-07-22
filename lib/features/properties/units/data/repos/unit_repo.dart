import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/unit_data_source.dart';
import '../model/unit_details_model.dart';
import '../model/units_model.dart';

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

  Future<Either<DioException, PaginationModel<UnitsModel>>> getAllUnits({
    required int propertyId,
    required int page,
  }) async {
    try {
      final remote = await _unitDetailsDataSource.getAllUnits(
        page: page,
        propertyId: propertyId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
