import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import 'general_design_for_booking_widget.dart';

class DiscountCodeWidget extends StatefulWidget {
  const DiscountCodeWidget({super.key});

  @override
  State<DiscountCodeWidget> createState() => _DiscountCodeWidgetState();
}

class _DiscountCodeWidgetState extends State<DiscountCodeWidget> {
  TextEditingController x = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForBookingWidget(
      title: S.of(context).haveCouponQuestion,
      child: Row(
        children: [
          Expanded(
            child: TextFormFieldWidget(
              fillColor: AppColors.scaffoldColor,
              controller: x,
            ),
          ),
          SizedBox(width: 12.w),
          DefaultButtonWidget(
            text: S.of(context).verifyCoupon,
            textColor: AppColors.primaryColor,
            height: 40.h,
            width: 80.w,
            fontWeight: FontWeight.w400,
            textSize: 11.sp,
            background: const Color(0xffe5eeff),
            borderRadius: 10.r,
          ),
        ],
      ),
    );
  }
}
