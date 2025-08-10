import 'package:booking/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rich_text_widget.dart';

class InfoHotelInCardBookingWidget extends StatelessWidget {
  final String title;
  final String location;
  final int count;
  final double price;
  final String currency;

  const InfoHotelInCardBookingWidget({
    super.key,
    required this.title,
    required this.location,
    required this.count,
    required this.price,
    this.currency = 'ريال',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.location,
                height: 10.h,
                color: const Color(0xff757575),
              ),
              2.horizontalSpace,
              Expanded(
                child: AutoSizeTextWidget(
                  text: location,
                  fontSize: 8.5.sp,
                  minFontSize: 7,
                  fontWeight: FontWeight.w400,
                  colorText: const Color(0xff757575),
                ),
              ),
            ],
          ),
          4.verticalSpace,
          Row(
            children: [
              AutoSizeTextWidget(
                text: 'عدد: $count',
                fontSize: 8.5.sp,
                minFontSize: 7,
                colorText: const Color(0xff757575),
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
              RichTextWidget(
                firstText: price.toStringAsFixed(0),
                secondText: " ريال",
                firstColor: AppColors.primaryColor,
                secondColor: const Color(0xff757575),
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                fontSizeSecondText: 11.sp,
                fontWeightSecondText: FontWeight.w300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
