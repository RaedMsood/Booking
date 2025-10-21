import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';
import '../../../../generated/l10n.dart';

class BillSummaryWidget extends StatelessWidget {
  final dynamic deposit;
  final dynamic totalPrice;

  const BillSummaryWidget({
    super.key,
    required this.deposit,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).cost,
                fontSize: 12.sp,
                colorText: const Color(0xff292D32),
              ),
              RichTextWidget(
                firstText: totalPrice.toString(),
                firstColor: const Color(0xff605A65),
                secondText: "ريال",
                secondColor: const Color(0xff757575),
                fontWeightSecondText: FontWeight.w300,
                fontSizeSecondText: 12.sp,
                fontSize: 14.sp,
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).grandTotal,
                fontSize: 12.sp,
                colorText: const Color(0xff292D32),
              ),
              RichTextWidget(
                firstText: totalPrice.toString(),
                firstColor: AppColors.primaryColor,
                secondText: " ريال",
                secondColor: const Color(0xff757575),
                fontWeightSecondText: FontWeight.w300,
                fontSizeSecondText: 12.sp,
                fontSize: 14.sp,
              ),
            ],
          ),
          6.verticalSpace,
          const Divider(
            color: Color(0xffF0F0F0),
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).depositAmount,
                fontSize: 12.sp,
                colorText: const Color(0xff292D32),
              ),
              RichTextWidget(
                firstText: deposit.toString(),
                firstColor: AppColors.primaryColor,
                secondText: " ريال",
                secondColor: const Color(0xff757575),
                fontWeightSecondText: FontWeight.w300,
                fontSizeSecondText: 12.sp,
                fontSize: 14.sp,
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).remainingAfterDeposit,
                fontSize: 12.sp,
                colorText: const Color(0xff292D32),
              ),
              RichTextWidget(
                firstText: (totalPrice - deposit).toString(),
                firstColor: const Color(0xff605A65),
                secondText: " ريال",
                secondColor: const Color(0xff757575),
                fontWeightSecondText: FontWeight.w300,
                fontSizeSecondText: 12.sp,
                fontSize: 14.sp,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
