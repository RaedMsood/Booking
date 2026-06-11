import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/payment_riverpod.dart';
import 'list_of_pay_method_widget.dart';

class PaymentMethodsSectionWidget extends ConsumerWidget {
  final String title;

  const PaymentMethodsSectionWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payState = ref.watch(getAllPaymentMethodsProvider);
    final errorMessage = ref.watch(selectedPayMethodErrorProvider);

    return CheckStateInGetApiDataWidget(
      state: payState,
      refresh: () {
        ref.invalidate(getAllPaymentMethodsProvider);
      },
      widgetOfData: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: title,
              fontSize: 11.sp,
            ),
            8.h.verticalSpace,
            if (errorMessage != null)
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: AutoSizeTextWidget(
                  text: errorMessage,
                  fontSize: 10.sp,
                  colorText: AppColors.dangerColor,
                ),
              ),
            ListOfPaymentMethodWidget(
              paymentData: payState.data,
            ),
          ],
        ),
      ),
      widgetOfLoading: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: title,
              fontSize: 11.sp,
            ),
            14.h.verticalSpace,
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


