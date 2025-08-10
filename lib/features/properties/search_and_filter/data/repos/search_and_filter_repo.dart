import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../home/data/model/property_data_model.dart';
import '../data_source/search_and_filter_remote_data_source.dart';
import '../model/filter_data_model.dart';

class SearchAndFilterReposaitory {
  final SearchAndFilterRemoteDataSource _remoteDataSource =
      SearchAndFilterRemoteDataSource();

  Future<Either<DioException, PaginationModel<PropertyDataModel>>>
      searchAndFilterProperties({
    required int page,
    String? search,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? cityId,
    int? priceFrom,
    int? priceTo,
    int? unitTypeId,
    List<int>? featureIds,
    List<int>? rating,
  }) async {
    try {
      final remote = await _remoteDataSource.searchAndFilterProperties(
        page: page,
        search: search,
        dateFrom: dateFrom,
        dateTo: dateTo,
        priceFrom: priceFrom,
        priceTo: priceTo,
        cityId: cityId,
        unitTypeId: unitTypeId,
        featureIds: featureIds,
        rating: rating,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, FilterDataModel>> getFilterData() async {
    try {
      final remote = await _remoteDataSource.getFilterData();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
