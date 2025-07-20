import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/state/pagination_data/paginated_model.dart';
import '../booking_model/booking_model.dart';
import '../data_source/booking_data_source.dart';

class BookingReposaitory{
  final BookingDataSource bookingDataSource = BookingDataSource();
  Future<Either<DioException, Unit>> checkBookingFromHotel({
    required BookingData bookingData,
  }) async {
    try {
      final remote = await bookingDataSource.checkBookingFromHotel(
        bookingData: bookingData,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, PaginationModel<BookingData>>> getBookingTypeFilter({
    required int page,
    required int filterType,
  }) async {
    try {
      final remote = await bookingDataSource.getBookingTypeFilter(page: page,filterType: filterType);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}