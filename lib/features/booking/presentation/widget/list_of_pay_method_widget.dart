import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/booking_model/payment_methods_model.dart';
import '../riverpod/booking_riverpod.dart';
import 'pay_method_card_widget.dart';

class ListOfPaymentMethodWidget extends ConsumerStatefulWidget {
  final List<PaymentMethodsModel> paymentData;

  const ListOfPaymentMethodWidget({super.key, required this.paymentData});

  @override
  ConsumerState<ListOfPaymentMethodWidget> createState() =>
      _ListOfPaymentMethodWidgetState();
}

class _ListOfPaymentMethodWidgetState
    extends ConsumerState<ListOfPaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.paymentData.length,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemBuilder: (context, index) {
        return PayMethodCardWidget(
          name: widget.paymentData[index].title,
          value: widget.paymentData[index].id.toString(),
          paymentMethodGroupValue:
              ref.read(selectedPayMethodProvider)?.id.toString() ?? '',
          onPressed: () {
            ref.read(selectedPayMethodProvider.notifier).state =
                widget.paymentData[index];
            setState(() {});
          },
        );
      },
      separatorBuilder: (context, index) => 8.h.verticalSpace,
    );
  }
}
