import 'package:flutter/material.dart';

typedef PaymentTextBuilder = String Function(BuildContext context);
typedef PaymentPhoneValidator = String? Function(
  BuildContext context,
  String? value,
);
typedef PaymentPhoneMapper = String Function(String value);

String _defaultPaymentPhoneMapper(String value) => value.trim();

class PaymentRequestContextModel {
  final Map<String, dynamic> payload;
  final Map<String, dynamic>? booking;
  final Map<String, dynamic>? customer;
  final double depositAmount;
  final String initialPhoneNumber;
  final int? phoneMaxLength;
  final bool showPhoneCounter;
  final PaymentPhoneValidator? phoneValidator;
  final PaymentPhoneMapper phoneNumberMapper;
  final PaymentPhoneMapper? floosakTargetPhoneMapper;
  final PaymentTextBuilder? floosakMinimumAmountErrorBuilder;

  PaymentRequestContextModel({
    Map<String, dynamic>? payload,
    this.booking,
    this.customer,
    this.depositAmount = 0,
    this.initialPhoneNumber = '',
    this.phoneMaxLength,
    this.showPhoneCounter = false,
    this.phoneValidator,
    PaymentPhoneMapper? phoneNumberMapper,
    this.floosakTargetPhoneMapper,
    this.floosakMinimumAmountErrorBuilder,
  })  : payload = Map.unmodifiable({
          if (payload != null) ...payload,
          if (booking != null && !(payload?.containsKey('booking') ?? false))
            'booking': booking,
          if (customer != null && !(payload?.containsKey('customer') ?? false))
            'customer': customer,
        }),
        phoneNumberMapper = phoneNumberMapper ?? _defaultPaymentPhoneMapper;

  Map<String, dynamic> get requestPayload {
    return payload;
  }

  String mapPhoneNumber(String value) {
    return phoneNumberMapper(value.trim());
  }

  String mapFloosakTargetPhone(String value) {
    final sanitized = value.trim();
    return (floosakTargetPhoneMapper ?? phoneNumberMapper)(sanitized);
  }

  String floosakMinimumAmountErrorText(BuildContext context) {
    return floosakMinimumAmountErrorBuilder?.call(context) ??
        'يجب أن يكون المبلغ المدخل مساويًا أو أكبر من مبلغ العربون';
  }
}

