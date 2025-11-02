import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../booking_model/booking_data.dart';
import '../booking_model/booking_data_model.dart';
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

  Future<Either<DioException, BookingDataModel>> custemorDataForBooking({
    required CustomerModel custemor,
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
    required BookingDataModel bookingData,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
  }) async {
    try {
      final remote = await bookingDataSource.confirmPayment(
        bookingData: bookingData,
        payMethodName: payMethodName,
        voucher: voucher,
        amount: amount,
        phoneNumber: phoneNumber,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
