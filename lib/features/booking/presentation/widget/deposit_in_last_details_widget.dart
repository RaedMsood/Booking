import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';

class DepositInLastDetailsWidget extends StatelessWidget {
  const DepositInLastDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 12.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: 'العربون',
            fontSize: 12,
          ),
          8.verticalSpace,
          RichTextWidget(
            firstText: "20000 ",
            firstColor: AppColors.primaryColor,
            secondText: "ريال",
            fontWeight: FontWeight.w400,
            secondColor: const Color(0xff757575),
            fontWeightSecondText: FontWeight.w300,
            fontSizeSecondText: 14.sp,
            fontSize: 16.sp,
          ),
          8.verticalSpace,
          AutoSizeTextWidget(
            text: 'سياسة الفندق : مبلغ العربون لا يرجع مطلقًا',
            fontSize: 12,
            colorText: Color(0xff757575),
            fontWeight: FontWeight.w400,
          ),
          6.verticalSpace,
        ],
      ),
    );
  }
}
