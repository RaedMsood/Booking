import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/pay_spec.dart';
import '../../data/model/payment_methods_model.dart';

class ManualPaymentWidget extends ConsumerStatefulWidget {
  final PaymentMethodsModel paymentMethod;
  final void Function(BuildContext context, WidgetRef ref, String? purchaseId)?
      onPaymentSuccess;

  const ManualPaymentWidget({
    super.key,
    required this.paymentMethod,
    this.onPaymentSuccess,
  });

  @override
  ConsumerState<ManualPaymentWidget> createState() =>
      _ManualPaymentWidgetState();
}

class _ManualPaymentWidgetState extends ConsumerState<ManualPaymentWidget> {
  final _formKey = GlobalKey<FormState>();
  final _purchaseIdController = TextEditingController();

  @override
  void dispose() {
    _purchaseIdController.dispose();
    super.dispose();
  }

  Future<void> _copyPointNumber(BuildContext context) async {
    final pointNumber = widget.paymentMethod.manualPointNumber.trim();
    if (pointNumber.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: pointNumber));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'تم نسخ رقم نقطة الدفع',
            style: TextStyle(fontFamily: 'ReadexPro', fontSize: 11.sp),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final spec = paySpecForPaymentMethod(widget.paymentMethod);
    if (spec == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w)
          .copyWith(bottom: 12.h, top: 2.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: spec.instruction,
              fontSize: 11.sp,
              colorText: AppColors.mainColorFont,
              maxLines: 3,
              fontWeight: FontWeight.w400,
            ),
            14.h.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeTextWidget(
                  text: 'رقم نقطة الدفع',
                  fontSize: 10.4.sp,
                  colorText: AppColors.mainColorFont,
                  fontWeight: FontWeight.w400,
                ),
                10.w.horizontalSpace,
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: widget.paymentMethod.manualPointNumber,
                            fontSize: 11.sp,
                            colorText: AppColors.fontColor,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                          ),
                        ),
                        8.w.horizontalSpace,
                        InkWell(
                          borderRadius: BorderRadius.circular(20.r),
                          onTap: () => _copyPointNumber(context),
                          child: Padding(
                            padding: EdgeInsets.all(4.sp),
                            child: Icon(
                              Icons.copy_rounded,
                              size: 18.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            12.h.verticalSpace,
            AutoSizeTextWidget(
              text: spec.codeLabel,
              fontSize: 10.4.sp,
              colorText: AppColors.mainColorFont,
              fontWeight: FontWeight.w400,
            ),
            6.h.verticalSpace,
            TextFormFieldWidget(
              controller: _purchaseIdController,
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
            16.h.verticalSpace,
            DefaultButtonWidget(
              text: S.of(context).confirmPayment,
              height: 40.h,
              textSize: 12.sp,
              onPressed: () {
                final isValid = _formKey.currentState?.validate() ?? false;
                if (!isValid) return;
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.of(context).pop();
                widget.onPaymentSuccess?.call(
                  context,
                  ref,
                  _purchaseIdController.text.trim(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

