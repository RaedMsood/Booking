import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';
import '../../../../generated/l10n.dart';
import 'general_design_for_booking_widget.dart';

class DepositInLastDetailsWidget extends StatelessWidget {
  const DepositInLastDetailsWidget({super.key, required this.deposit});

  final dynamic deposit;

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForBookingWidget(
      title:S.of(context).depositSectionTitle,
      fontSize: 12.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            firstText: "$deposit ",
            firstColor: AppColors.primaryColor,
            secondText: "ريال",
            fontWeight: FontWeight.w400,
            secondColor: const Color(0xff757575),
            fontWeightSecondText: FontWeight.w300,
            fontSizeSecondText: 13.sp,
            fontSize: 15.sp,
          ),
          8.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).hotelPolicyNote,
            fontSize: 12,
            colorText: const Color(0xff757575),
            fontWeight: FontWeight.w400,
          ),
          6.verticalSpace,
        ],
      ),
    );

  }
}
