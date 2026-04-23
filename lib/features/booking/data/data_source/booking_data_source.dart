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
    final parsed = BookingData.fromJson(response.data['data']['id']);
    return parsed.copyWith(
      totalPrice: parsed.totalPrice ?? bookingData.totalPrice,
      price: parsed.price ?? bookingData.price,
      hasDiscount: parsed.hasDiscount || bookingData.hasDiscount,
    );
  }

  Future<BookingDataModel> custemorDataForBooking({
    required CustomerModel custemor,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.custemorForBooking,
      data: custemor.toJson(),
    );
    final parsed = BookingDataModel.fromJson(response.data['data']);
    final requestBooking = custemor.booking;
    if (requestBooking == null) return parsed;

    return BookingDataModel(
      bookingData: parsed.bookingData.copyWith(
        totalPrice: parsed.bookingData.totalPrice ?? requestBooking.totalPrice,
        price: parsed.bookingData.price ?? requestBooking.price,
        hasDiscount: parsed.bookingData.hasDiscount || requestBooking.hasDiscount,
      ),
      customer: parsed.customer,
    );
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
    final normalizedMethodName = normalizePayMethodName(payMethodName);
    final requestMethodName = payMethodName.trim().toLowerCase();
    final isJawaliLikeMethod =
        isJawaliPayMethod(payMethodName) || isJaibPayMethod(payMethodName);
    await RemoteRequest.postData(
      path: AppURL.confirmPayment,
      data: {
        "booking": bookingData.bookingData.toJson(),
        "customer": bookingData.customer?.toJson(),
        "payment_method_name": requestMethodName.isNotEmpty
            ? requestMethodName
            : normalizedMethodName,
        if (isJawaliLikeMethod) "voucher": voucher,
        if (isJawaliLikeMethod) "receiver_mobile": phoneNumber,
        if (normalizedMethodName == "kuraimi") "pin_pass": voucher,
        if (normalizedMethodName == "kuraimi") "amount": amount,
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
