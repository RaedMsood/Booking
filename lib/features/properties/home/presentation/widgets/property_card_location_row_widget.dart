import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class PropertyCardLocationRowWidget extends StatelessWidget {
  final String city;
  final String district;
  final double iconHeight;
  final double fontSize;

  const PropertyCardLocationRowWidget({
    super.key,
    required this.city,
    required this.district,
    required this.iconHeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.location,
          height: iconHeight,
          colorFilter: const ColorFilter.mode(
            AppColors.fontColor,
            BlendMode.srcIn,
          ),
        ),
        4.w.horizontalSpace,
        Expanded(
          child: AutoSizeTextWidget(
            text: '$city, $district',
            fontSize: fontSize,
            colorText: AppColors.fontColor,
            minFontSize: 8,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

