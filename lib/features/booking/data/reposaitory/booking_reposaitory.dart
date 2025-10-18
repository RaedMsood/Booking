import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../booking_model/booking_model.dart';
import '../booking_model/payment_methods_model.dart';
import '../data_source/booking_data_source.dart';

class BookingReposaitory {
  final BookingDataSource bookingDataSource = BookingDataSource();

  Future<Either<DioException, BookingData>> checkBookingFromHotel({
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

  Future<Either<DioException, BookingData>> custemorDataForBooking({
    required Customer custemor,
  }) async {
    try {
      final remote = await bookingDataSource.custemorDataForBooking(
        custemor: custemor,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<PaymentMethodsModel>>>
      getAllPaymentMethods() async {
    try {
      final remote = await bookingDataSource.getAllPaymentMethods();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> confirmPayment({
    required int bookingId,
    required String payMethodName,
    required String voucher,
    required int amount,
  }) async {
    try {
      final remote = await bookingDataSource.confirmPayment(
        bookingId: bookingId,
        payMethodName: payMethodName,
        voucher: voucher,
        amount: amount,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
