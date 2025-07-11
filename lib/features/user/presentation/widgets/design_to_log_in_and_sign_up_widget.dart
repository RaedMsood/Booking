import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';

class DesignToLogInAndSignUpWidget extends StatelessWidget {
  final Widget widget;

  const DesignToLogInAndSignUpWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primarySwatch.shade100.withOpacity(.7),
                AppColors.primarySwatch.shade50.withOpacity(.4),
                AppColors.scaffoldColor,
                AppColors.scaffoldColor,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.topPattern,
            height: 180.h,
            color: Colors.black54,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primarySwatch.shade100.withOpacity(.7),
                  AppColors.primarySwatch.shade50.withOpacity(.4),
                  AppColors.scaffoldColor,
                  AppColors.scaffoldColor,
                  AppColors.scaffoldColor,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
            ),
            child: SvgPicture.asset(
              AppIcons.bottomPattern,
              height: 190.h,
              color: Colors.black54,
            ),
          ),
        ),
        widget,
      ],
    );
  }
}
