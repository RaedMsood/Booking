import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_icons.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

void showModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor:backgroundColor?? Colors.white,
    builder: (context) =>  Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: page,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.sp),
        topRight: Radius.circular(14.sp),
      ),
    ),
  );
}

void showTitledBottomSheet({
  required BuildContext context,
  required Widget page,
  required String title,
  Color? backgroundColor,
  double? fontSize,

}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    builder: (context) => Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42.w,
            height: 4.4.h,
            margin: EdgeInsets.only(bottom: 4.h, top: 8.h),
            decoration: BoxDecoration(
              color: AppColors.fontColor2.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Row(
            children: [
              12.w.horizontalSpace,
              AutoSizeTextWidget(
                text: title,
                colorText: AppColors.mainColorFont,
                fontSize:fontSize??14.sp ,
              ),
              const Spacer(),
              IconButtonWidget(
                icon: AppIcons.close,
                height: 15.h,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              4.w.horizontalSpace,
            ],
          ),
          Flexible(child: page),
        ],
      ),
    ),
  );
}

void scrollShowModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9, // الحجم الابتدائي عند فتحه (50% من الشاشة)
      minChildSize: 0.5, // الحد الأدنى للحجم
      maxChildSize: 0.98, // الحد الأقصى للحجم عند السحب
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14.sp)),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: page,
          ),
        );
      },
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.sp),
        topRight: Radius.circular(14.sp),
      ),
    ),
  );
}