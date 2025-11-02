import 'package:dartz/dartz.dart';
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
    required CustomerModel custemor,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.custemorForBooking,
      data: custemor.toJson(),
    );
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
    required BookingDataModel bookingData,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
  }) async {
    await RemoteRequest.postData(
      path: AppURL.confirmPayment,
      data: {
        "booking": bookingData.bookingData.toJson(),
        "customer": bookingData.customer?.toJson(),
        "payment_method_name": payMethodName,
        if (payMethodName == "jawali") "voucher": voucher,
        if (payMethodName == "jawali") "receiver_mobile": phoneNumber,
        if (payMethodName == "kuraimi") "pin_pass": voucher,
        if (payMethodName == "kuraimi") "amount": amount,
      },
    );
    return Future.value(unit);
  }
}
