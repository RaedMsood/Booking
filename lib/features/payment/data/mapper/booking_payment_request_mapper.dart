import '../../../booking/data/booking_model/booking_data_model.dart';
import '../model/payment_request_context_model.dart';

extension BookingPaymentRequestMapper on BookingDataModel {
  PaymentRequestContextModel toPaymentRequest({
    required String initialPhoneNumber,
    required PaymentPhoneValidator phoneValidator,
    PaymentTextBuilder? floosakMinimumAmountErrorBuilder,
    String floosakCountryCode = '967',
    int phoneMaxLength = 9,
  }) {
    return PaymentRequestContextModel(
      payload: {
        'booking': bookingData.toJson(),
        if (customer != null) 'customer': customer!.toJson(),
      },
      depositAmount: double.tryParse(bookingData.deposit.toString()) ?? 0,
      initialPhoneNumber: initialPhoneNumber,
      phoneMaxLength: phoneMaxLength,
      showPhoneCounter: false,
      phoneValidator: phoneValidator,
      phoneNumberMapper: (value) => value.trim(),
      floosakTargetPhoneMapper: (value) =>
          '$floosakCountryCode${value.trim()}',
      floosakMinimumAmountErrorBuilder: floosakMinimumAmountErrorBuilder,
    );
  }
}

