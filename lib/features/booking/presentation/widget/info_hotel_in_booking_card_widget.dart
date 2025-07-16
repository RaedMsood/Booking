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
    Key? key,
    required this.title,
    required this.location,
    required this.count,
    required this.price,
    this.currency = 'ريال',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
               //const Icon(Icons.location_on, size: 11, color: Colors.grey),
              SvgPicture.asset(
                AppIcons.location,
                height: 10.h,
                color: Color(0xff757575),

              ),
              Expanded(
                child: AutoSizeTextWidget(
                  text: location,
                  fontSize: 9,
                  minFontSize: 7,
                  fontWeight: FontWeight.w400,
                  colorText: Color(0xff757575),
                ),
              ),
            ],
          ),
          4.verticalSpace,
          Row(
            children: [
              AutoSizeTextWidget(
                text: 'عدد: $count',
                fontSize: 9,
                minFontSize: 7,
                colorText: Color(0xff757575),
                fontWeight: FontWeight.w400,
              ),
              Spacer(),
              // AutoSizeTextWidget(
              //   text: '${price.toStringAsFixed(0)} $currency',
              //   fontSize: 12,
              //   colorText: AppColors.primaryColor,
              //   fontWeight: FontWeight.w400,
              //
              // ),
              RichTextWidget(
                firstText: "50000 ",
                secondText: "ريال",
                firstColor: AppColors.primaryColor,
                secondColor: Color(0xff757575),
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
