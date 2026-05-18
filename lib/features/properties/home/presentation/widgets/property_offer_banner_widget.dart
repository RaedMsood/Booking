import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';

class PropertyOfferBannerWidget extends StatelessWidget {
  const PropertyOfferBannerWidget({
    super.key,
    required this.text,
    this.iconPath = 'assets/icons/star_of_offer.svg',
    this.backgroundColor = const Color(0xffE5EEFF),
    this.borderColor = AppColors.primaryColor,
    this.textColor = AppColors.primaryColor,
  });

  final String text;
  final String iconPath;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 25.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
          ),
          4.w.horizontalSpace,
          Flexible(
            child: AutoSizeTextWidget(
              text: text,
              fontSize: 10.sp,
              colorText: textColor,
              fontWeight: FontWeight.w500,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

