import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../booking_model/booking_data.dart';
import '../booking_model/booking_data_model.dart';
import '../booking_model/payment_methods_model.dart';

class BookingDataSource {
  Future<BookingData> checkBookingFromHotel({
    required BookingData bookingData,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkBookingHotel,
      data: bookingData.toJson(),
    );
    return BookingData.fromJson(response.data['data']['id']);
  }

  Future<BookingDataModel> custemorDataForBooking({
    required Customer custemor,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.custemorForBooking,
      data: custemor.toJson(),
    );
    debugPrint(response.statusCode.toString());

    return BookingDataModel.fromJson(response.data['data']);
  }

  Future<List<PaymentMethodsModel>> getAllPaymentMethods() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllPaymentMethods,
    );
    return PaymentMethodsModel.fromJsonList(
        response.data['data']['payment_methods']);
  }

  Future<Unit> confirmPayment({
    required int bookingId,
    required String payMethodName,
    required String voucher,
    required int amount,
  }) async {
    await RemoteRequest.postData(
      path: AppURL.confirmPayment,
      data: {
        "booking_id": bookingId,
        "payment_method_name": payMethodName,
        if (payMethodName == "jawali") "voucher": voucher,
        if (payMethodName == "kuraimi") "pin_pass": voucher,
        if (payMethodName == "kuraimi") "amount": amount,
      },
    );
    return Future.value(unit);
  }
}
