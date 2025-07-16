import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/text_form_field.dart';

class DiscountCodeWidget extends StatelessWidget {
  DiscountCodeWidget({super.key});
  TextEditingController x = TextEditingController();

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
            AutoSizeTextWidget(
              text: 'لديك قسيمة تخفيض؟',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 16.w),
                //     height: 45.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12.r),
                //       color: Colors.grey.shade100,
                //     ),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: TextField(
                //             textDirection: TextDirection.ltr,
                //             decoration: InputDecoration(
                //               border: InputBorder.none,
                //               hintText: '****',
                //               hintStyle: TextStyle(fontSize: 14.sp),
                //             ),
                //             style: TextStyle(fontSize: 14.sp),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: TextFormFieldWidget(
                    fillColor: AppColors.scaffoldColor,
                    controller: x,
                  ),
                ),
                SizedBox(width: 12.w),

                DefaultButtonWidget(
                  text: "تحقق",
                  textColor: AppColors.primaryColor,
                  height: 45.h,
                  width: 80.w,
                  fontWeight: FontWeight.w400,
                  textSize: 12,
                  background:  Color(0xffD4EDDA),
                  borderRadius: 12.r,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
