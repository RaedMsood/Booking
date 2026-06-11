import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/pay_spec.dart';
import '../../data/model/payment_request_context_model.dart';
import '../riverpod/payment_riverpod.dart';
import 'pay_method_widget.dart';

class PaymentActionButtonWidget extends ConsumerWidget {
  final PaymentRequestContextModel paymentRequest;
  final String buttonText;
  final double? height;
  final void Function(BuildContext context, WidgetRef ref, String? purchaseId)?
      onPaymentSuccess;

  const PaymentActionButtonWidget({
    super.key,
    required this.paymentRequest,
    required this.buttonText,
    this.height,
    this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultButtonWidget(
      text: buttonText,
      height: height,
      onPressed: () {
        final selectedPayMethod = ref.read(selectedPayMethodProvider);
        final paySpec = paySpecForPaymentMethod(selectedPayMethod);

        if (selectedPayMethod == null) {
          ref.read(selectedPayMethodErrorProvider.notifier).state =
              S.of(context).pleaseSelectPaymentMethod;
          return;
        }

        ref.read(selectedPayMethodErrorProvider.notifier).state = null;

        showTitledBottomSheet(
          context: context,
          title: paySpec?.requiresCodeField == false
              ? selectedPayMethod.title
              : (paySpec?.codeLabel.isNotEmpty == true
                  ? paySpec!.codeLabel
                  : selectedPayMethod.title),
          page: PayMethodWidget(
            paymentRequest: paymentRequest,
            onPaymentSuccess: onPaymentSuccess,
          ),
        );
      },
    );
  }
}

