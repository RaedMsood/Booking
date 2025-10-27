import 'package:booking/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../my_bookings/presentation/riverpod/my_bookings_riverpod.dart';
import '../../data/booking_model/pay_spec.dart';
import '../riverpod/booking_riverpod.dart';
import 'booking_success_dialog_widget.dart';

class PayMethodWidget extends ConsumerStatefulWidget {
  final int bookingId;

  const PayMethodWidget({super.key, required this.bookingId});

  @override
  ConsumerState<PayMethodWidget> createState() => _PayMethodWidgetState();
}

class _PayMethodWidgetState extends ConsumerState<PayMethodWidget> {
  TextEditingController voucherController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedPayMethod =
        ref.watch(selectedPayMethodProvider.notifier).state;
    if (selectedPayMethod!.name.isEmpty) return const SizedBox.shrink();
    final spec = paySpecs[selectedPayMethod.name];
    var state = ref.watch(confirmPaymentProvider);
    if (spec!.requiresPhoneNumber) {
      phoneNumberController.text = Auth().phoneNumber;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w)
          .copyWith(bottom: 12.h, top: 2.h),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: spec!.instruction,
              fontSize: 11.sp,
              colorText: AppColors.mainColorFont,
              maxLines: 2,
              fontWeight: FontWeight.w400,
            ),
            12.h.verticalSpace,
            Visibility(
              visible: spec.requiresPhoneNumber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: S.of(context).phoneNumber,
                    fontSize: 10.4.sp,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w400,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: phoneNumberController,
                    type: TextInputType.phone,
                    maxLength: 9,
                    buildCounter: false,
                    fillColor: AppColors.scaffoldColor,
                    hintText: S.of(context).phonePlaceholder,
                    fieldValidator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return S.of(context).phoneRequired;
                      }
                      final phone = value.trim();
                      if (!phone.startsWith('7')) {
                        return S.of(context).phoneMustStartWith7;
                      }
                      if (phone.length < 9) {
                        return S.of(context).phoneMustBe9Digits;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            8.h.verticalSpace,
            AutoSizeTextWidget(
              text: spec.codeLabel,
              fontSize: 10.4.sp,
              colorText: AppColors.mainColorFont,
              fontWeight: FontWeight.w400,
            ),
            6.h.verticalSpace,
            TextFormFieldWidget(
              controller: voucherController,
              type: TextInputType.text,
              fillColor: AppColors.scaffoldColor,
              hintText: spec.codeHint,
              fieldValidator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return spec.codeEmptyError;
                }
                return null;
              },
            ),
            Visibility(
              visible: spec.requiresAmount,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: S.of(context).amountLabel,
                    fontSize: 10.4.sp,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w400,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: amountController,
                    type: TextInputType.number,
                    fillColor: AppColors.scaffoldColor,
                    hintText: "0.0",
                    fieldValidator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return S.of(context).amountValidation;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            16.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: state,
              hasMessageSuccess: false,
              functionSuccess: () {
                CompleteBooking.successDialog(context, ref);
                ref.refresh(getBookingProvider(0));
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirmPayment,
                height: 40.h,
                textSize: 12.sp,
                isLoading: state.stateData == States.loading,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();

                  if (!isValid) return;

                  FocusManager.instance.primaryFocus?.unfocus();
                  ref.read(confirmPaymentProvider.notifier).confirmPayment(
                        bookingId: widget.bookingId,
                        payMethodName: selectedPayMethod.name,
                        voucher: voucherController.text,
                        amount: int.tryParse(amountController.text) ?? 0,
                        phoneNumber: phoneNumberController.text,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
