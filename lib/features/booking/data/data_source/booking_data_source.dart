import 'package:dartz/dartz.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../booking_model/booking_data.dart';
import '../booking_model/booking_data_model.dart';
import '../booking_model/floosak_payment_session_model.dart';
import '../booking_model/payment_methods_model.dart';
import '../booking_model/pay_spec.dart';

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
    final methods = PaymentMethodsModel.fromJsonList(
      response.data['data']['payment_methods'],
    );

    return methods;
  }

  Future<Unit> confirmPayment({
    required BookingDataModel bookingData,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
  }) async {
    final methodName = normalizePayMethodName(payMethodName);
    await RemoteRequest.postData(
      path: AppURL.confirmPayment,
      data: {
        "booking": bookingData.bookingData.toJson(),
        "customer": bookingData.customer?.toJson(),
        "payment_method_name": methodName,
        if (methodName == "jawali") "voucher": voucher,
        if (methodName == "jawali") "receiver_mobile": phoneNumber,
        if (methodName == "kuraimi") "pin_pass": voucher,
        if (methodName == "kuraimi") "amount": amount,
      },
    );
    return Future.value(unit);
  }

  Future<FloosakPaymentSessionModel> startFloosakPayment({
    required BookingDataModel bookingData,
    required String payMethodName,
    required String phoneNumber,
    required int amount,
  }) async {
    final methodName = normalizePayMethodName(payMethodName);
    final response = await RemoteRequest.postData(
      path: AppURL.startFloosakPayment,
      data: {
        // 'booking': bookingData.bookingData.toJson(),
        // 'customer': bookingData.customer?.toJson(),
        'payment_method_name': methodName,
        'target_phone': '967$phoneNumber',
        'amount': amount,
      },
    );

    final data = response.data['data'];
    return FloosakPaymentSessionModel.fromJson(
      data is Map<String, dynamic> ? data : <String, dynamic>{},
      paymentMethodName: methodName,
      phoneNumber: phoneNumber,
      amount: amount,

    );
  }

  Future<Unit> confirmFloosakPayment({
    required BookingDataModel bookingData,
    required FloosakPaymentSessionModel session,
    required String otp,
  }) async {
    await RemoteRequest.postData(
      path: AppURL.confirmFloosakPayment,
      data: {
        'booking': bookingData.bookingData.toJson(),
        'customer': bookingData.customer?.toJson(),
        'payment_method_name': normalizePayMethodName(session.paymentMethodName),
        'target_phone': session.phoneNumber,
        'amount': session.amount,
        'purchase_id': session.purchaseId,
        'otp': otp,
      },
    );
    return Future.value(unit);
  }
}
