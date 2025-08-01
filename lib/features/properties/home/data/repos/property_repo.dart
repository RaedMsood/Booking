import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/property_remote_data_source.dart';
import '../model/property_data_model.dart';
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

  Future<Either<DioException, PaginationModel<PropertyDataModel>>>
  searchAndFilterProperties ({
    required int page,
    String? search,
    int? cityId,
    int? priceFrom,
    int? priceTo,
    int? unitId,
    List<int>? featureId,
  }) async {
    try {
      final remote =
          await _propertyRemoteDataSource.searchAndFilterProperties (
        page: page,
        search: search,
        cityId: cityId,
        priceFrom: priceFrom,
        priceTo: priceTo,
        unitId: unitId,
        featureId: featureId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
