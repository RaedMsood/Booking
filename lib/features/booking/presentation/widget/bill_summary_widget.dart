import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';
import '../page/pay_page.dart';

class BillSummaryWidget extends StatelessWidget {
  const BillSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: "التكلفة",
                    fontSize: 12.sp,
                    colorText: Color(0xff292D32),
                  ),
                  RichTextWidget(
                    firstText: "50000 ",
                    firstColor: const Color(0xff605A65),
                    secondText: "ريال",
                    secondColor:const Color(0xff757575),
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
                    text: "الاجمالي",
                    fontSize: 12.sp,
                    colorText: Color(0xff292D32),
                  ),
                  RichTextWidget(
                    firstText: "50000 ",
                    firstColor: AppColors.primaryColor,
                    secondText: "ريال",
                    secondColor:const Color(0xff757575),
                    fontWeightSecondText: FontWeight.w300,
                    fontSizeSecondText: 12.sp,
                    fontSize: 14.sp,

                  ),
                ],
              ),
              6.verticalSpace,
              Divider(color: Color(0xffF0F0F0),),
              6.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: "العربون",
                    fontSize: 12.sp,
                    colorText: Color(0xff292D32),
                  ),
                  RichTextWidget(
                    firstText: "20000 ",
                    firstColor: AppColors.primaryColor,
                    secondText: "ريال",
                    secondColor:const Color(0xff757575),
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
                    text: "المتبقي بعد العربون",
                    fontSize: 12.sp,
                    colorText: Color(0xff292D32),
                  ),
                  RichTextWidget(
                    firstText: "50000 ",
                    firstColor: const Color(0xff605A65),
                    secondText: "ريال",
                    secondColor:const Color(0xff757575),
                    fontWeightSecondText: FontWeight.w300,
                    fontSizeSecondText: 12.sp,
                    fontSize: 14.sp,

                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
