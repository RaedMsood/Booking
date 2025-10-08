import 'package:booking/features/booking/data/booking_model/rate_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../booking_model/booking_model.dart';
import '../booking_model/payment_methods_model.dart';

class BookingDataSource {
  Future<int> checkBookingFromHotel({
    required BookingData bookingData,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkBookingHotel,
      data: bookingData.toJson(),
    );
    return response.data['data']['id'];
  }

  Future<PaginationModel<BookingData>> getBookingTypeFilter({
    required int filterType,
    required int page,
    int perPage = 5,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getBookingType}$filterType",
      query: {
        'page': page,
        'perPage': 4,
      },
    );

    return PaginationModel<BookingData>.fromJson(
      response.data['data'] ?? response.data,
      (book) {
        return BookingData.fromJson(book);
      },
    );
  }

  Future<BookingData> custemorDataForBooking({
    required Customer custemor,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.custemorForBooking,
      data: custemor.toJson(),
    );
    debugPrint(response.statusCode.toString());

    return BookingData.fromJson(response.data['data']);
  }

  Future<Unit> rateTheProperty(
      {required List<RateModel> rate,
      required int idProperty,
      required int idBooking}) async {
    final response = await RemoteRequest.postData(
      path: AppURL.rateProperty,
      data: {
        "property_id": idProperty,
        "criteria": RateModel.toJsonList(rate),
        'booking_id': idBooking
      },
    );
    debugPrint(response.statusCode.toString());

    return Future.value(unit);
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
