import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class AudienceInDetailsBookingWidget extends StatelessWidget {
  const AudienceInDetailsBookingWidget({super.key,required this.numChild,required this.numGuests});
  final int numGuests;
  final int numChild;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 12.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          AutoSizeTextWidget(
            text: 'بيانات الحضور',
            fontSize: 12,
          ),
          // 8.verticalSpace,
          // Row(
          //   children: [
          //     SvgPicture.asset(
          //       AppIcons.profile,
          //       height: 17.h,
          //       color: Color(0xff605A65),
          //
          //     ),
          //     10.horizontalSpace,
          //     AutoSizeTextWidget(
          //       text: 'شباب',
          //       fontSize: 12,
          //       fontWeight: FontWeight.w400,
          //       colorText: Color(0xff757575),
          //     ),
          //   ],
          // ),
          8.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.people,
                height: 17.h,
                color: Color(0xff605A65),

              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text: '$numGuests شخص ($numChild أطفال)',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                colorText: Color(0xff757575),
              ),
            ],
          ),
          6.verticalSpace,
        ],
      ),
    );
  }
}
