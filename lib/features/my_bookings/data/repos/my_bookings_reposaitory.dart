import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../my_bookings/data/model/rate_model.dart';
import '../data_source/my_bookings_data_source.dart';
import '../model/my_bookings_data.dart';

class MyBookingsReposaitory {
  final MyBookingsDataSource myBookingsDataSource = MyBookingsDataSource();

  Future<Either<DioException, PaginationModel<MyBookingsData>>>
      getBookingTypeFilter({
    required int page,
    required int filterType,
  }) async {
    try {
      final remote = await myBookingsDataSource.getBookingTypeFilter(
          page: page, filterType: filterType);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> rateTheProperty(
      {required int idProperty,
      required List<RateModel> rate,
      required int idBooking}) async {
    try {
      final remote = await myBookingsDataSource.rateTheProperty(
        idBooking: idBooking,
        rate: rate,
        idProperty: idProperty,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
