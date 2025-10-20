import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';

class FilterAndUndoFilterButtonWidget extends StatelessWidget {

  final VoidCallback clickOnFilter;
  final VoidCallback clickOnUndoFilter;

  const FilterAndUndoFilterButtonWidget(
      {super.key, required this.clickOnFilter, required this.clickOnUndoFilter,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 8.h),
          child: Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).applyFilter,
                  height: 40.h,
                  textSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  borderRadius: 8.r,
                  onPressed:clickOnFilter,
                  withIcon: true,
                  icon: AppIcons.filter,
                  iconColor: Colors.white,
                  iconHeight: 18.h,
                ),
              ),
              14.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).clearFilters,
                  background: Colors.white,
                  textColor: AppColors.primaryColor,
                  height: 40.h,
                  textSize: 12.5.sp,
                  borderRadius: 8.r,
                  fontWeight: FontWeight.w400,
                  border: Border.all(
                      color: AppColors.primaryColor.withOpacity(.4),
                      width: 0.4.w),
                  onPressed: clickOnUndoFilter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
