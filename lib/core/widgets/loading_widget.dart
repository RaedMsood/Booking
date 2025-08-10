import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w,).copyWith(bottom: 38.h),
      child:  Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2.6.w,
        ),
      ),
    );
  }
}
