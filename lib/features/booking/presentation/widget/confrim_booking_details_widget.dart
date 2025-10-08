import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';

class ConfrimBookingDetailsWidget extends StatelessWidget {
  const ConfrimBookingDetailsWidget(
      {super.key,
      required this.checkOut,
      required this.unitCount,
      required this.totalPrice,
      required this.bookAt,
      required this.checkIn});

  final double totalPrice;
  final String bookAt;
  final String unitCount;
  final String checkIn;
  final String checkOut;

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
            text: 'تاكيد الحجز',
            fontSize: 12,
          ),
          6.verticalSpace,
          RichTextWidget(
            firstText: "$totalPrice ",
            firstColor: AppColors.primaryColor,
            secondText: "ريال",
            fontWeight: FontWeight.w400,
            secondColor: const Color(0xff757575),
            fontWeightSecondText: FontWeight.w300,
            fontSizeSecondText: 14.sp,
            fontSize: 16.sp,
          ),
          Divider(
            thickness: 1,
            color: Color(0xffF0F0F0),
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.date,
                height: 17.h,
                color: Color(0xff605A65),
              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text: 'تاريخ الحجز $checkIn',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                colorText: Color(0xff757575),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.buliding,
                height: 17.h,
                color: Color(0xff605A65),
              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text: '$unitCount غرف',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                colorText: Color(0xff757575),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.clock,
                height: 17.h,
                color: Color(0xff605A65),
              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text: 'من $checkIn الى $checkOut',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                colorText: Color(0xff757575),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
